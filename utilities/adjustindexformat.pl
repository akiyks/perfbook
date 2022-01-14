#!/usr/bin/env perl
# SPDX-License-Identifier: GPL-2.0-or-later

use strict;
use warnings;

my $line;

open(my $fh, '<:encoding(UTF-8)', $ARGV[0])
    or die "Could not open file '$ARGV[0]' $!";

while($line = <$fh>) {
    $line =~ s/\{([^\|]+)(\|hyperindexformat)\{\\bf(@\\makefirstuc )\{.+\}\}\}/\{$1$3\{$1\}$2\{\\BF\}\}/ ;
    $line =~ s/\{([^\|]+)(\|hyperindexformat)\{\\bf(@\\makefirstuc )\{.+\}!([^\}]+)\}\}/\{$1$3\{$1}!$4$2\{\\BF\}\}/ ;
    $line =~ s/(\\makefirstuc )\{([^\)]+)\} \[([^\]]+)\]\|hyperpage\}/$1\{$2\} \($3\)|hyperindexformat\{\\BF\}\}/ ;
    $line =~ s/\{([^\|]+)(\|hyperindexformat)\{\\gl(@\\makefirstuc )\{.+\}\}\}/\{$1$3\{$1\}$2\{\\GL\}\}/ ;
    $line =~ s/\{([^\|]+)(\|hyperindexformat)\{\\gl(@\\makefirstuc )\{.+\}!([^\}]+)\}\}/\{$1$3\{$1}!$4$2\{\\GL\}\}/ ;
    $line =~ s/(\\makefirstuc )\{([^\)]+)\} \<([^\]]+)\>\|hyperpage\}/$1\{$2\} \($3\)|hyperindexformat\{\\GL\}\}/ ;
    print $line ;
}
