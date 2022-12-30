# fixfig2devfonts-urwps.sh: Convert an .eps file from eps2dev to use
#                           embeddable fonts
#
# Based on fixfonts.sh, updated for fig2dev by Akira Yokosawa
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
# Copyright (c) 2011-2019 Paul E. McKenney, IBM Corporation.
# Copyright (c) 2019 Paul E. McKenney, Facebook.
# Copyright (c) 2018, 2021, 2022 Akira Yokosawa.

if test -z "$1"
then
	echo No EPS file specified, aborting.
	exit 1
fi
sed -i  -e 's+Times-Roman-iso+NimbusSans-iso+g' \
	-e 's+Times-Roman+NimbusSans-Regular+g' \
	-e 's+Helvetica-iso+NimubsSans-iso+g' \
	-e 's+Helvetica-Narrow-iso+NimbusSans-Narrow-iso+g' \
	-e 's+Helvetica-Bold+NimbusSans-Bold+g' \
	-e 's+Helvetica-Narrow+NimubsSansNarrow-Regular+g' \
	-e 's+Helvetica+NimbusSans-Regular+g' \
	-e 's+Courier-iso+NimbusMono-iso+g' \
	-e 's+Courier-Bold+NimbusMonoPS-Bold+g' \
	-e 's+Courier+NimbusMonoPS-Regular+g' \
	-e 's+NimbusMonoPS-Regular+DejaVuSansMono+g' $1
