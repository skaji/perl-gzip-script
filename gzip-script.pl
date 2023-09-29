#!/usr/bin/env perl
use v5.38;
use experimental qw(builtin class defer for_list try);

use IO::Compress::Gzip ();

my $script = shift or die "Usage: $0 script.pl\n";

print {\*STDOUT} <<'EOF';
#!/usr/bin/env perl
use v5.16;
use IO::Uncompress::Gunzip ();
IO::Uncompress::Gunzip::gunzip \*DATA, \my $script, AutoClose => 1 or die $IO::Uncompress::Gunzip::GunzipError;
eval '#line 1'.' "'.__FILE__."\"\n" . $script;
die $@ if $@;
__DATA__
EOF

IO::Compress::Gzip::gzip $script, \*STDOUT,
    Append => 1,
    Minimal => 1,
    Level => IO::Compress::Gzip::Z_BEST_COMPRESSION,
or die $IO::Compress::Gzip::GzipError;
