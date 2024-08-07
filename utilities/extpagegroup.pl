#!/usr/bin/env perl
# SPDX-License-Identifier: GPL-2.0-or-later
#
# Extract "page group object" in PDF generated by Inkscape
#
# Copyright (C) Akira Yokosawa, 2019
#
# Authors: Akira Yokosawa <akiyks@gmail.com>

use strict;
use warnings;

my $line;
my $in_pagegroup = 0;

while($line = <>) {
    if ($in_pagegroup == 3) {
	$in_pagegroup = 0;
	print $line;
    }
    if ($in_pagegroup == 2) {
	if ($line =~ /\/Group/) {
	    $in_pagegroup = 3;
	}
	print $line;
    }
    if ($in_pagegroup == 1) {
	if ($line =~ /\/Group/) {
	    $in_pagegroup = 2;
	    print $line;
	}
    }
    if ($in_pagegroup == 0 && $line =~ /\/Contents/) {
	$in_pagegroup = 1;
    }
    if (eof) { last; }
}
