#!/bin/sh
#
# Run pdflatex on the specified file.
# Attempt to avoid useless repeats.
# This version is heavily customized to be used for perfbook.
# It is assumed to be used together with runfirstlatex.sh
# and Makefile of perfbook.
#
# Usage: sh runlatex.sh file[.tex]
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
# Copyright (C) IBM Corporation, 2012-2019
# Copyright (C) Facebook, 2019
# Copyright (C) Akira Yokosawa, 2016, 2017
#
# Authors: Paul E. McKenney <paulmck@us.ibm.com>
#          Akira Yokosawa <akiyks@gmail.com>

diff_warning () {
	if diff -q $basename-warning.log $basename-warning-prev.log >/dev/null
	then
		echo "No more improvement is expected, giving up."
		return 0 ;
	else
#		echo "Some improvements are observed, continuing."
		return 1 ;
	fi
}

identical_warnings () {
	if test -r $basename-warning-prev.log
	then
		if test "$iter" -gt "$min_iter" && diff_warning
		then
			return 0 ;
		fi
	fi
	return 1 ;
}

exerpt_warnings () {
	if grep -q "LaTeX Warning:" $basename.log
	then
		echo "----- Excerpt around remaining warning messages -----"
		grep -B 8 -A 5 "LaTeX Warning:" $basename.log | tee $basename-warning.log
		echo "----- You can see $basename-warning.log for the warnings above. -----"
		echo "----- If you need to, see $basename.log for details. -----"
		rm -f $basename-warning-prev.log
		exit 1
	fi
}

iterate_latex () {
	makeindex $basename.idx > /dev/null 2>&1
	pdflatex $LATEX_OPT $basename > /dev/null 2>&1 < /dev/null || :
	if grep -q '! Emergency stop.' $basename.log
	then
		grep -B 15 -A 5 '! Emergency stop.' $basename.log
		echo "----- Fatal latex error, see $basename.log for details. -----"
		exit 1
	fi
	if grep -q '!pdfTeX error:' $basename.log
	then
		grep -A 2 '!pdfTeX error:' $basename.log
		echo "----- Fatal latex error, see $basename.log for details. -----"
		exit 1
	fi
	if test -r $basename-warning.log
	then
		mv -f $basename-warning.log $basename-warning-prev.log
	fi
	grep 'LaTeX Warning:' $basename.log > $basename-warning.log
	return 0 ;
}

if test -z "$1"
then
	echo No latex file specified, aborting.
	exit 1
fi

basename=`echo $1 | sed -e 's/\.tex$//'`

if ! test -r $basename-first.log
then
	echo "No need to update aux and bbl files."
	echo "pdflatex 1 for $basename.pdf"
	iter=1
else
	rm -f $basename-first.log
	echo "pdflatex 2 for $basename.pdf # for possible bib update"
	iter=2
fi
iterate_latex
min_iter=2
while grep -q 'LaTeX Warning: There were undefined references' $basename.log
do
	if test $undefined_refs
	then
		echo "Undefined refs remain, giving up."
		exerpt_warnings
	fi
	if identical_warnings
	then
		break
	fi
	iter=`expr $iter + 1`
	echo "pdflatex $iter for $basename.pdf # remaining undefined refs"
	undefined_refs=1
	iterate_latex
done
min_iter=3
while grep -q 'LaTeX Warning: Label(s) may have changed' $basename.log
do
	if identical_warnings
	then
		break
	fi
	iter=`expr $iter + 1`
	echo "pdflatex $iter for $basename.pdf # label(s) may have changed"
	iterate_latex
done
exerpt_warnings
rm -f $basename-warning.log $basename-warning-prev.log
echo "'$basename.pdf' is ready."
# cleveref version check (Ubuntu 18.04 LTS has buggy one
if grep -q -F "packageversion{0.21.1}" `kpsewhich cleveref.sty`
then
	echo "############################################################"
	echo "### Buggy version of LaTeX package 'cleveref' detected!! ###"
	echo "### (Known issue on Ubuntu 18.04 LTS)                    ###"
	echo "### Please consider installing a stable version.         ###"
	echo "### See item 10 in FAQ-BUILD.txt for further info.       ###"
	echo "############################################################"
fi
# to avoid redundant run of bibtex and pdflatex
touch $basename.bbl
touch $basename.pdf
sh utilities/mpostcheck.sh
exit 0
