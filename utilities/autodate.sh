#!/bin/sh
#
# Extract git commit date info to generate autodate.tex.
# If invoked on not-clean git repository, append "(m)" to date field
# for title.
# If git status is not availabe, use current date instead.
# If --endash option is given,
# call utilities/dohyphen2endash.sh on clean git repository.
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
# Copyright (C) Akira Yokosawa, 2017
#
# Authors: Akira Yokosawa <akiyks@gmail.com>

# parse option
TEMP=`getopt -o e --long endash -- "$@"`

if [ $? != 0 ] ; then echo "Error in parse option..." >&2 ; exit 1 ; fi

eval set -- "$TEMP"

doendash=0

while true ; do
	case "$1" in
		-e|--endash) doendash=1 ; shift ;;
		--) shift ; break ;;
		*) echo "Unknown option!" ; exit 1 ;;
	esac
done

export LC_TIME=C
# check if we are in git repository
if ! test -e .git
then
	date_str=`date -R`
	modified="(u)"
else
	date_str=`git show --format="%cD" | head -1`
	# check if git status is clean
	gitstatus=`git status --porcelain | wc -l`
	if [ $gitstatus != "0" ]
	then
		modified="(m)"
	else
		modified=""
	fi
fi
month=`date --date="$date_str" +%B`
year=`date --date="$date_str" +%Y`
day=`date --date="$date_str" +%e`

# call dohyphen2endash if not modified and --endash is given
if [ $doendash -eq 1 ]
then
	if [ -z "$modified" ]
	then
		echo "replacing hyphens to endashes" 1>&2
		sh utilities/dohyphen2endash.sh > /dev/null
		modified="(--)"
	else
		echo "git status not clean, skipping endash replacement" 1>&2
	fi
fi

env printf "\\date{%s %s, %s \\scriptsize{%s}}\n" $month $day $year $modified
env printf "\\\newcommand{\\\commityear}{%s}\n" $year

exit 0
