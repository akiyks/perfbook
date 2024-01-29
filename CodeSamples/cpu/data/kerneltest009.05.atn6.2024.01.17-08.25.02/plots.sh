#!/bin/sh

gnuplot << ---EOF---
set term png
set output "coe-nvals.png"
set xlabel "Time (Timestamp Periods)"
set ylabel "Number of Simultaneous Values"
#set logscale y
set xrange [:10000]
#set yrange [100:10000]
set nokey
# set label 1 "RCU" at 0.1,10 left
# set label 2 "spinlock" at 0.5,3.0 left
# set label 3 "brlock" at 0.4,0.6 left
# set label 4 "rwlock" at 0.3,1.6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "coe-nvals.dat" w l
---EOF---

gnuplot << ---EOF---
set term png
set output "coe.png"
set xlabel "Store-to-Store Latency (Timestamp Periods)"
set ylabel "Number of Samples"
#set logscale y
set xrange [-1000:3000]
set yrange [0:]
set nokey
# set label 1 "RCU" at 0.1,10 left
# set label 2 "spinlock" at 0.5,3.0 left
# set label 3 "brlock" at 0.4,0.6 left
# set label 4 "rwlock" at 0.3,1.6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "coe.dat" w points pt 6 pointsize 0.2
---EOF---

gnuplot << ---EOF---
set term png
set output "fre.png"
set xlabel "Store-to-Load Latency (Timestamp Periods)"
set ylabel "Number of Samples"
#set logscale y
set xrange [-250:50]
set yrange [0:]
set nokey
# set label 1 "RCU" at 0.1,10 left
# set label 2 "spinlock" at 0.5,3.0 left
# set label 3 "brlock" at 0.4,0.6 left
# set label 4 "rwlock" at 0.3,1.6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "fre.dat" w points pt 6 pointsize 0.5
---EOF---

gnuplot << ---EOF---
set term png
set output "rfe.png"
set xlabel "Store-to-Load Latency (Timestamp Periods)"
set ylabel "Number of Samples"
#set logscale y
set xrange [0:350]
set yrange [0:]
set nokey
# set label 1 "RCU" at 0.1,10 left
# set label 2 "spinlock" at 0.5,3.0 left
# set label 3 "brlock" at 0.4,0.6 left
# set label 4 "rwlock" at 0.3,1.6 left
# set label 5 "refcnt" at 0.15,2.8 left
plot "rfe.dat" w points pt 6 pointsize 0.5
---EOF---

# For eps output
font=../../../../fonts/uhvr8a.pfb
fontsize=8
przsize="nosquare 0.55,0.25"

gnuplot << ---EOF---
set term postscript portrait color ${fontsize} enhanced fontfile "${font}" "NimbusSanL-Regu" 
set size $przsize
set output "coe-nvals.eps"

set xlabel "Time (Timestamp Periods)"
set ylabel "Number of Simultaneous Values"
#set logscale y
set xrange [:10000]
#set yrange [100:10000]
set nokey
plot "coe-nvals.dat" w l
---EOF---

gnuplot << ---EOF---
set term postscript portrait color ${fontsize} enhanced fontfile "${font}" "NimbusSanL-Regu"
set size $przsize
set output "coe.eps"
stats "coe-dist.dat" nooutput
N = STATS_records

set xlabel "Store-to-Store Latency (Timestamp Periods)"
set ylabel "Frequency (arb. unit)"
#set logscale y
set xrange [-1000:3000]
set yrange [0:]
set nokey
#set border 3
set yzeroaxis
set boxwidth 20
#set style fill solid 1.0 noborder
bin_width = 20
bin(x) = bin_width * floor(x/bin_width)
plot "coe-dist.dat" using (bin(column(1))):(20./N) smooth frequency with boxes
---EOF---

gnuplot << ---EOF---
set term postscript portrait color ${fontsize} enhanced fontfile "${font}" "NimbusSanL-Regu"
set size $przsize
set output "fre.eps"
stats "fre-dist.dat" nooutput
N = STATS_records

set xlabel "Load-to-Store Latency (Timestamp Periods)"
set ylabel "Frequency (arb. unit)"
#set logscale y
set xrange [-250:50]
set yrange [0:]
set nokey
set yzeroaxis
set boxwidth 2
#set style fill solid 1.0 noborder
bin_width = 2
bin(x) = bin_width * floor(x/bin_width)
plot "fre-dist.dat" using (bin(column(1))):(20./N) smooth frequency with boxes
---EOF---

gnuplot << ---EOF---
set term postscript portrait color ${fontsize} enhanced fontfile "${font}" "NimbusSanL-Regu"
set size $przsize
set output "rfe.eps"
stats "rfe-dist.dat" nooutput
N = STATS_records

set xlabel "Store-to-Load Latency (Timestamp Periods)"
set ylabel "Frequency (arb. unit)"
#set logscale y
set xrange [0:350]
set yrange [0:]
set nokey
set yzeroaxis
set boxwidth 2
#set style fill solid 1.0 noborder
bin_width = 2
bin(x) = bin_width * floor(x/bin_width)
plot "rfe-dist.dat" using (bin(column(1))):(20./N) smooth frequency with boxes
---EOF---
