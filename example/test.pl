#!/usr/bin/env perl
use v5.16;
use warnings;

use FindBin;

warn "line number (actual 7)";
warn "\$FindBin::Bin: $FindBin::Bin\n";
warn "\$0: $0\n";
warn "\$ARGV[$_]: $ARGV[$_]\n" for 0 .. $#ARGV;
