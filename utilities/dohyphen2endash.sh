#!/bin/sh
#
# Apply hypen2endash.sh for all .tex files
# If invoked in non-clean git status, this script will abort.
# If invoked with the "--force" option, this script will continue
# regardless of git status.
# If invoked with the "--untracked" option, this script will check
# git status with untracked files ignored.
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
# Copyright (C) Akira Yokosawa, 2016, 2017
#
# Authors: Akira Yokosawa <akiyks@gmail.com>

# parse option
TEMP=`getopt -o fu --long force,untracked -- "$@"`

if [ $? != 0 ] ; then echo "Error in parse option..." >&2 ; exit 1 ; fi

eval set -- "$TEMP"

forced=0
untracked=0

while true ; do
	case "$1" in
		-f|--force) forced=1 ; shift ;;
		-u|--untracked) untracked=1 ; shift ;;
		--) shift ; break ;;
		*) echo "Unknown option!" ; exit 1 ;;
	esac
done
# check if we are in git repository
if ! test -e .git
then
	echo "not in a git repository"
	exit 1
fi
# check if companion script exists
if ! test -e utilities/hyphen2endash.sh
then
	echo "utilities/hyphen2endash.sh not found."
	exit 1
fi
# prepare git status option
if [ $untracked -eq 1 ]
then
	git_stat_option="--porcelain -uno"
else
	git_stat_option="--porcelain"
fi
# check if git status is clean
gitstatus=`git status $git_stat_option | wc -l`
if [ $forced -eq 0 -a $gitstatus != "0" ]
then
	echo "git status not clean --- aborting."
	exit 1
fi
texfiles=`find . -name '*.tex' -print`
tmpf=`mktemp`
for i in $texfiles
do
	basename="${i%.tex}"
#	echo $basename
	sh ./utilities/hyphen2endash.sh $basename.tex > $tmpf
	if ! diff -q $basename.tex $tmpf >/dev/null
	then
		echo "$basename.tex modified"
		cp -f $tmpf $basename.tex
	fi
done
bibfiles=`find bib -name '*.bib' -print`
for i in $bibfiles
do
	basename="${i%.bib}"
#	echo $basename.bib
	sh ./utilities/bibhyphen2endash.sh $basename.bib > $tmpf
	if ! diff -q $basename.bib $tmpf >/dev/null
	then
		echo "$basename.bib modified"
		cp -f $tmpf $basename.bib
	fi
done
rm -f $tmpf
