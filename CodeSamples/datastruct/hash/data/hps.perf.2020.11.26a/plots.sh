#! /bin/sh
#
# Create plots from the hash-table test programs.
#
# Usage: sh plots.sh tag perfbook-path
#
# Execute this script in the directory containing the data.
# The tag is the same string passed to reduce.sh.  The perfbook-path
# is the path to the top-level perfbook directory, defaulting to ../../.
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
# Copyright (C) IBM Corporation, 2013-2019
# Copyright (C) Facebook, 2019
#
# Authors: Paul E. McKenney <paulmck@kernel.org>

tag=${1-hps.2020.11.26a}
font=${2-../../../../../}
texpath=../../../../../datastruct/
plotpath=../CodeSamples/datastruct/hash/data/hps.perf.2020.11.26a

fontsize=10
plotsize=0.5

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "perftest.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Lookups per Millisecond"
set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "unsync" at 10,1500000 left rotate by 25
set label 2 "RCU,hazptr" at 40,500000 left rotate by 29
set label 3 "bucket" at 40,130000 left
set label 4 "global" at 5,4500 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "perftest.hash_bkt.${tag}.dat" w l dashtype 2, "perftest.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "perftest.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "perftest.hash_global.${tag}.dat" w l dashtype 5, "perftest.hash_unsync.${tag}.dat" w l dashtype 6
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "perftestlin.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Lookups per Millisecond"
# set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "unsync" at 250,1.28e7 left
set label 2 "RCU" at 350,8.8e6 right
set label 3 "hazptr" at 200,3.5e6 left
set label 4 "bucket" at 330,1.1e6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "perftest.hash_bkt.${tag}.dat" w l dashtype 2, "perftest.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "perftest.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "perftest.hash_unsync.${tag}.dat" w l dashtype 6
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpu.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "global" at 7,8300 left
set label 2 "bucket" at 60,100000 left
set label 3 "RCU" at 170,3200000 right rotate by 28
set label 4 "hazptr" at 350,2000000 right rotate by 28
set label 5 "ideal" at 35,2500000 right
plot "zoo.cpus.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.cpus.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.cpus.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "zoo.cpus.hash_global.${tag}.dat" w l dashtype 5, x*44666.3 w l dashtype 1
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpulin.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
#set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "RCU" at 300,4000000 left
set label 2 "hazptr" at 300,1900000 left
set label 3 "ideal" at 400,14000000 right
# set label 4 "unsync" at 250,5000000 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.cpus.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.cpus.hash_bkt_rcu.${tag}.dat" w l dashtype 4, x*44666.3 w l dashtype 1
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpulinqsbr.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
#set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "QSBR,RCU" at 200,4000000 left
set label 2 "hazptr" at 300,1900000 left
set label 3 "ideal" at 400,14000000 right
# set label 4 "qsbr" at 400,14000000 right
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.cpus.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.cpus.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "zoo.cpus.hash_bkt_qsbr.${tag}.dat" w l dashtype 8, x*44666.3 w l dashtype 1
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpulinqsbrunsync.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
#set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "unsync,QSBR,RCU" at 170,5200000 left
set label 2 "hazptr" at 300,1900000 left
set label 3 "ideal" at 400,14000000 right
# set label 4 "qsbr" at 400,14000000 right
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.cpus.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.cpus.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "zoo.cpus.hash_bkt_qsbr.${tag}.dat" w l dashtype 8, "zoo.cpus.hash_unsync.${tag}.dat" w l dashtype 6, x*44666.3 w l dashtype 1
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpu-unsync.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "global" at 7,8300 left
set label 2 "bucket" at 60,100000 left
set label 3 "RCU,hazptr" at 350,2000000 right rotate by 28
set label 4 "unsync" at 200,5000000 right rotate by 26
set label 5 "ideal" at 35,2500000 right
plot "zoo.cpus.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.cpus.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.cpus.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "zoo.cpus.hash_global.${tag}.dat" w l dashtype 5, "zoo.cpus.hash_unsync.${tag}.dat" w l dashtype 6, x*44666.3 w l dashtype 1
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpu-unsynclin.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
#set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
# set label 1 "bucket" at 300,740000 left
set label 2 "RCU,hazptr" at 300,1900000 left
set label 3 "ideal" at 400,14000000 right
set label 4 "unsync" at 250,5000000 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.cpus.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.cpus.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "zoo.cpus.hash_unsync.${tag}.dat" w l dashtype 6, x*44666.3 w l dashtype 1
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpubktlin8.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
#set logscale xy
set xrange [1:28]
#set yrange [100:10000]
set nokey
set label 1 "ideal" at 22,750000 right
set label 2 "bucket" at 20,110000 left
# set label 3 "brlock" at 0.4,0.6 left
# set label 4 "rwlock" at 0.3,1.6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.cpus.hash_bkt.${tag}.dat" w l dashtype 2, x*44666.3 w l dashtype 1
# plot "zoo.cpus.hash_bkt.${tag}.dat" w l, "zoo.cpus.hash_unsync.${tag}.dat" w l, x*44666.3 w l
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpubktlin.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
#set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
# set label 1 "RCU" at 0.1,10 left
# set label 2 "spinlock" at 0.5,3.0 left
# set label 3 "brlock" at 0.4,0.6 left
# set label 4 "rwlock" at 0.3,1.6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.cpus.hash_bkt.${tag}.dat" w l dashtype 2
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocpubktsizelin.eps"
set xlabel "Number of CPUs (Threads)"
set ylabel "Total Lookups per Millisecond"
#set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
# set label 1 "1024" at 40,23000 left
# set label 2 "2048" at 40,41800 left
# set label 3 "4096" at 32,46000 left
# set label 4 "8192" at 44,50000 left
# set label 5 "16384" at 40,55000 left
plot "zoo.cpus.hash_bkt.${tag}.dat" w l, "zoo.cpus.hash_bkt-65536.${tag}.dat" w l, "zoo.cpus.hash_bkt-131072.${tag}.dat" w l, "zoo.cpus.hash_bkt-262144.${tag}.dat" w l, "zoo.cpus.hash_bkt-524288.${tag}.dat" w l, "zoo.cpus.hash_bkt-1048576.${tag}.dat" w l
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocatall.eps"
set xlabel "Number of CPUs Looking Up The Cat"
set ylabel "Total Lookups per Millisecond"
set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "RCU" at 20,2e6 left
set label 2 "hazptr" at 15,500000 left
set label 3 "bucket" at 10,100000 left
set label 4 "global" at 2,4000 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.catall.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.catall.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.catall.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "zoo.catall.hash_global.${tag}.dat" w l dashtype 5
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocatalllin.eps"
set xlabel "Number of CPUs Looking Up The Cat"
set ylabel "Total Lookups per Millisecond"
#set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "RCU" at 30,1.5e6 left
set label 2 "hazptr" at 15,600000 left
set label 3 "bucket" at 10,230000 left
# set label 4 "rwlock" at 0.3,1.6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.catall.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.catall.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.catall.hash_bkt_rcu.${tag}.dat" w l dashtype 4
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocatall-unsync.eps"
set xlabel "Number of CPUs Looking Up The Cat"
set ylabel "Total Lookups per Millisecond"
set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "RCU" at 33,1.1e6 left font ",8"
set label 2 "hazptr" at 15,500000 left
set label 3 "bucket" at 10,100000 left
set label 4 "global" at 2,4000 left
set label 5 "unsync" at 15,2.7e6 left
# set label 5 "ideal" at 0.15,2.8 left
plot "zoo.catall.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.catall.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.catall.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "zoo.catall.hash_global.${tag}.dat" w l dashtype 5, "zoo.catall.hash_unsync.${tag}.dat" w l dashtype 6
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocatonly.eps"
set xlabel "Number of CPUs Looking Up The Cat"
set ylabel "Cat Lookups per Millisecond"
set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "global" at 2,70 left
set label 2 "bucket" at 3,2000 left
set label 3 "hazptr" at 10,70000 left
set label 4 "RCU" at 10,450000 right
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.cat.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.cat.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.cat.hash_bkt_rcu.${tag}.dat" w l dashtype 4, "zoo.cat.hash_global.${tag}.dat" w l dashtype 5
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zoocatonlylin.eps"
set xlabel "Number of CPUs Looking Up The Cat"
set ylabel "Cat Lookups per Millisecond"
#set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "RCU" at 57,1.75e6 right
set label 2 "hazptr" at 42,500000 left
# set label 3 "brlock" at 0.4,0.6 left
# set label 4 "rwlock" at 0.3,1.6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.cat.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.cat.hash_bkt_rcu.${tag}.dat" w l dashtype 4
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zooupdatelu.eps"
set xlabel "Number of CPUs Doing Updates"
set ylabel "Lookups per Millisecond"
set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "global" at 10,1000 right
set label 2 "bucket" at 10,100000 left
set label 3 "hazptr" at 80,800000 right
set label 4 "RCU" at 130,3400000 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.updrd.hash_global.${tag}.dat" w l dashtype 5, "zoo.updrd.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.updrd.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.updrd.hash_bkt_rcu.${tag}.dat" w l dashtype 4
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zooupdatelulin.eps"
set xlabel "Number of CPUs Doing Updates"
set ylabel "Lookups per Millisecond"
set logscale y
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "RCU" at 350,1.25e6 left
set label 2 "hazptr" at 250,3.3e5 left
set label 3 "bucket" at 200,37000 left
set label 4 "global" at 50,800 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.updrd.hash_global.${tag}.dat" w l dashtype 5, "zoo.updrd.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.updrd.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.updrd.hash_bkt_rcu.${tag}.dat" w l dashtype 4
---EOF---

gnuplot << ---EOF---
set term postscript portrait ${fontsize} enhanced "NimbusSanL-Regu" fontfile "${font}fonts/uhvr8a.pfb"
set size square ${plotsize},${plotsize}
set output "zooupdate.eps"
set xlabel "Number of CPUs Doing Updates"
set ylabel "Updates per Millisecond"
set logscale xy
#set yrange [1:10000]
#set yrange [100:10000]
set nokey
set label 1 "global" at 10,150 left
set label 2 "bucket" at 300,280000 right
set label 3 "RCU" at 120,12000 left
set label 4 "hazptr" at 50,45000 right
# set label 5 "refcnt" at 0.15,2.8 left
plot "zoo.upd.hash_global.${tag}.dat" w l dashtype 5, "zoo.upd.hash_bkt.${tag}.dat" w l dashtype 2, "zoo.upd.hash_bkt_hazptr.${tag}.dat" w l dashtype 3, "zoo.upd.hash_bkt_rcu.${tag}.dat" w l dashtype 4
---EOF---

# Create/update symlink from datastruct/
for f in zoocatonly zoocpu zoocpubktlin zoocpubktlin8 zoocpubktsizelin \
	 zoocpulin zoocpulinqsbr zoocpulinqsbrunsync zooupdate zooupdatelu
do
	ln -sf $plotpath/$f.eps $texpath
done
