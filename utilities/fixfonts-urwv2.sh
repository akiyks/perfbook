# fixfonts.sh: Convert an .eps file to use embeddable fonts, taking from
#	standard input and putting on standar output.
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
# Copyright (c) 2011 Paul E. McKenney, IBM Corporation.

sed	-e 's+Times-Roman+NimbusSans-Regular+g' \
	-e 's+Times+NimbusSans-Regular+g' \
	-e 's+Helvetica-BoldOblique+NimbusSans-BoldItalic+g' \
	-e 's+Helvetica-Oblique+NimbusSans-Italic+g' \
	-e 's+Helvetica-Bold+NimbusSans-Bold+g' \
	-e 's+Helvetica-Bold-iso+NimbusSans-Bold+g' \
	-e 's+Helvetica+NimbusSans-Regular+g' \
	-e 's+Helvetica-iso+NimbusSans-Regular+g' \
	-e 's+Symbol+StandardSymbolsPS+g' \
	-e 's+Courier+NimbusMono-Regular+g' \
	-e 's+Courier-Bold+NimbusMono-Bold+g' \
	-e 's+Courier-Oblique+NimbusMono-Italic+g' \
	-e 's+Courier-BoldOblique+NimbusMono-BoldItalic+g' \
	-e 's+NimbusSanL-Regu+NimbusSans-Regular+g' \
	-e 's+StandardSymbL+StandardSymbolsPS+g'
