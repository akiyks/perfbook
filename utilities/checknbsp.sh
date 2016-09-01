#!/bin/sh
#
# Add necessary nbsps around numbers
#
# Replacement candidates are
# nn byte -> nn~byte
# Line nn -> Line~nn
# line nn -> line~nn
# Lines nn -> Lines~nn
# lines nn -> lines~nn
# CPU nn -> CPU~nn
# Thread nn -> Thread~nn
# and nn -> and~nn
# through nn -> through~nn
# ...
#
# Several rules at the end are to revert inappropriate changes
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
# Copyright (C) Akira Yokosawa, 2016
#
# Authors: Akira Yokosawa <akiyks@gmail.com>

cat $1 |
	sed -e 's/\( [0-9]\+\) byte/\1~byte/g' \
	    -e 's/^\([0-9]\+\) byte/\1~byte/g' \
	    -e 's/\([0-9]\+\) \?\([GMk]Hz\)/\1~\2/g' \
	    -e 's/\([0-9]\+\) \?kW/\1~kW/g' \
	    -e 's/\([0-9]\+\) \?\([GMK]B\)/\1~\2/g' \
	    -e 's/\([0-9]\+\) \?ns/\1~ns/g' \
	    -e 's/\([lL]ines\?\) \([0-9]\+\)/\1~\2/g' \
	    -e "s/CPU \([0-9]\+[,\.\']\?[[:space:]]\+\)/CPU~\1/g" \
	    -e 's/\([tT]hread\) \([0-9A-Z]\{1\} \)/\1~\2/g' \
	    -e "s/and \([0-9]\+[,\.\']\?[[:space:]]\+\)/and~\1/g" \
	    -e "s/and \([0-9]\+[,\.\']\?\)$/and~\1/g" \
	    -e 's/and \(\\ref{[^}]*}\)/and~\1/g' \
	    -e "s/through \([0-9]\{1,3\}[,\.\']\?[[:space:]]\+\)/through~\1/g" \
	    -e "s/through \([0-9]\{1,3\}[,\.\']\?\)$/through~\1/g" \
	    -e 's/Figure \(\\ref{[^}]*}\)/Figure~\1/g' \
	    -e 's/Table \(\\ref{[^}]*}\)/Table~\1/g' \
	    -e 's/Chapter \(\\ref{[^}]*}\)/Chapter~\1/g' \
	    -e 's/Section \(\\ref{[^}]*}\)/Section~\1/g' \
	    -e 's/\\co{CPU~\([0-9]\+\)}/\\co{CPU \1}/g' \
	    -e 'sX/\* Line~\([0-9]\+\)X/* Line \1Xg' \
	    -e 'sX/\* Lines~\([0-9]\+\)X/* Lines \1Xg' \
	    -e 'sX/\* \(.*\) and~\([0-9]\+\) \*/X/* \1 and \2 */Xg' \
	    -e 's/^\(.* proc .* line\)~\([0-9]\+ .*\)$/\1 \2/g' \
	    -e 's/^\(.*line\)~\([0-9]\+.* "-end-"\)$/\1 \2/g' \
	    -e 's/\([0-9]\+\)~byte \(.*\);$/\1 byte \2;/g' \
	    -e 's/^\(State-vector [0-9]\+\)~\(byte, depth reached .*\)$/\1 \2/g' \
	    -e 's/\(\\label{[^}]*[0-9]\+\)~\(GHz[^}]*}\)/\1 \2/g' \
	    -e 's/\(\\ref{[^}]*[0-9]\+\)~\([kG]Hz[^}]*}\)/\1 \2/g' \
	    -e 's/\(\\pageref{[^}]*[0-9]\+\)~\(GHz[^}]*}\)/\1 \2/g' \
	    -e 's/\(\\includegraphics{[^}]*[0-9]\+\)~\(kHz[^}]*}\)/\1\2/g' \
	    -e 's/\(\\ContributedBy{[^}]*}{[^}]*[0-9]\+\)~\(kHz[^}]*}\)/\1 \2/g' \
	    -e 's/POWER[ \-]\?\([5-9]\)/POWER\1/g' \
	    -e 's/Power[ \-]\?\([5-9]\)/POWER\1/g' \

#	    -e 's/\\co{\(.*CPU\)~~\([0-9]\+.*\)}/\\co{\1 \2}/g' \
#	    -e 's/\(\\caption{.*[0-9]\+\)~\(GHz.*}\)/\1 \2/g' \
