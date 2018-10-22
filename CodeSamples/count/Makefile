# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, you can access it online at
# http://www.gnu.org/licenses/gpl-2.0.html.
#
# Copyright (c) 2009 Paul E. McKenney, IBM Corporation.

include ../Makefile.arch

PROGS =	count_atomic \
	count_end \
	count_end_rcu \
	count_lim \
	count_lim_app \
	count_lim_atomic \
	count_lim_sig \
	count_limd \
	count_nonatomic \
	count_stack \
	count_stat \
	count_stat_atomic \
	count_stat_eventual \
	count_tstat

RCU_SRCS = ../defer/rcu_nest32.h ../defer/rcu_nest32.c

top := ..
include $(top)/depends.mk

ifeq ($(strip $(target)),)
all:
	@echo "### None in count/ can be built on arch: '$(arch)'."
else
all: $(PROGS)
endif

CC?=cc

include $(top)/recipes.mk

count_atomic: count_atomic.c ../api.h counttorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_atomic count_atomic.c

count_end: count_end.c ../api.h counttorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_end count_end.c

count_end_rcu: count_end_rcu.c ../api.h counttorture.h $(RCU_SRCS)
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_end_rcu count_end_rcu.c

count_lim: count_lim.c ../api.h limtorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_lim count_lim.c

count_lim_app: count_lim_app.c ../api.h limtorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_lim_app count_lim_app.c

count_lim_atomic: count_lim_atomic.c ../api.h limtorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_lim_atomic count_lim_atomic.c

count_lim_sig: count_lim_sig.c ../api.h limtorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_lim_sig count_lim_sig.c

count_limd: count_limd.c ../api.h limtorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_limd count_limd.c

count_nonatomic: count_nonatomic.c ../api.h counttorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_nonatomic count_nonatomic.c

count_stack: count_stack.c ../api.h counttorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_stack count_stack.c

count_stat: count_stat.c ../api.h counttorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_stat count_stat.c

count_stat_atomic: count_stat_atomic.c ../api.h counttorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_stat_atomic count_stat_atomic.c

count_stat_eventual: count_stat_eventual.c ../api.h counttorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_stat_eventual count_stat_eventual.c

count_tstat: count_tstat.c ../api.h counttorture.h
	$(CC) $(GCC_ARGS) $(CFLAGS) -pthread -o count_tstat count_tstat.c

clean:
	rm -f $(PROGS)
