/*
 * existence.h: Definitions for managing existence data structures.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, you can access it online at
 * http://www.gnu.org/licenses/gpl-2.0.html.
 *
 * Copyright (c) 2014-2019 Paul E. McKenney, IBM Corporation.
 * Copyright (c) 2019 Paul E. McKenney, Facebook.
 */

#ifndef __EXISTENCE_H
#define __EXISTENCE_H

#define _GNU_SOURCE
#define _LGPL_SOURCE
#define RCU_SIGNAL
#include <urcu.h>

/* Existence structure associated with each moving structure. */
struct existence {
	const int **existence_switch;
	int offset;
};

/* Existence-group structure associated with multi-structure change. */
struct existence_group {
	struct existence outgoing;
	struct existence incoming;
	const int *existence_switch;
	struct rcu_head rh;
	struct existence_group *next;
};

/*
 * Existence-group per-thread cache structure, which can be wired up to
 * dump excess free blocks to another such cache.  Multilevel linkages
 * are not allowed.
 */
struct existence_group_cache {
	struct existence_group *free;
	struct existence_group **tail;
	long nfree;
	struct existence_group_cache *egcp;
	spinlock_t lock __attribute__((__aligned__(CACHE_LINE_SIZE)));
	struct existence_group *ffree;
	struct existence_group **ftail;
	long nffree;
	struct rcu_head rh;
};

void existence_wire_call_rcu(void);
struct existence_group *existence_alloc(void);
void existence_free(struct existence_group *egp);
void existence_switch(struct existence_group *egp);
int _existence_exists(struct existence *ep);
int _existence_exists_relaxed(struct existence *ep);
struct existence *existence_get(struct existence **epp);
struct existence *existence_get_relaxed(struct existence **epp);
struct existence *existence_get_outgoing(struct existence_group *egp);
struct existence *existence_get_incoming(struct existence_group *egp);
void existence_set(struct existence **epp, struct existence *ep);
void existence_clear(struct existence **epp);
int existence_is_outgoing(struct existence **epp);
int existence_is_incoming(struct existence **epp);

static inline int existence_exists(struct existence **epp)
{
	struct existence *ep = smp_load_acquire(epp);

	if (likely(ep == NULL))
		return 1;
	return _existence_exists(ep);
}

static inline int existence_exists_relaxed(struct existence **epp)
{
	struct existence *ep = rcu_dereference(*epp);

	if (likely(ep == NULL))
		return 1;
	return _existence_exists_relaxed(ep);
}

/*
 * Is the referenced existence pointer involved in an existence-change
 * operation?
 */
static inline int existence_is_changing(struct existence **epp)
{
	return ACCESS_ONCE(*epp) != NULL;
}

#endif /* #ifndef __EXISTENCE_H */
