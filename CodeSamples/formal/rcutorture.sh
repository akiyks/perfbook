#!/bin/bash
#
# rcutorture.sh: Output gnuplot .dat entries showing the fraction of
#	Linux-kernel RCU that is test code.  Run in a git clone of
#	the Linux-kernel source tree.
#
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
# Copyright (c) 2019 Paul E. McKenney, Facebook.

# Override by saying, e.g.:
#     "SINCE=v6 sh <path of this script>"
: ${SINCE:=v2.6.12}

tags="`git tag -l | grep -E -e '^v(2\.6|[3-9]|[1-9][0-9]+)\.[0-9]+$' | sort -V`"

for t in $tags
do
	tagsince=`echo "$SINCE\n$t" | sort -V | head -n 1`
	if [ $tagsince != $SINCE ] ; then
		continue
	fi
	git reset --hard $t > /dev/null 2>&1
	nontorture="`ls kernel/*rcu*.* kernel/rcu/* include/linux/*rcu* 2> /dev/null | grep -v torture | grep -v rcuperf | grep -v refperf | grep -v rcuscale | grep -v refscale | grep -v Makefile | grep -v Kconfig`"
	ntn="`wc -l $nontorture 2> /dev/null | tail -1 | awk '{ print $1 }'`"
	tn="`wc -l tools/testing/selftests/rcutorture/configs/*/*.sh kernel/rcutorture.c kernel/rcu/torture.c kernel/rcu/rcutorture.c kernel/rcu/rcuperf.c kernel/rcu/refperf.c kernel/rcu/rcuscale.c kernel/rcu/refscale.c kernel/torture.c tools/testing/selftests/rcutorture/bin/* 2> /dev/null | tail -1 | awk '{ print $1 }'`"
	frac="`awk -v ntn=$ntn -v tn=$tn 'END { printf "%.1f", 100 * tn / (tn + ntn) "%"; }' < /dev/null`"
	echo $t  $ntn $tn $((ntn + tn)) $frac
done
