[![Actions Status](https://github.com/skaji/perl-gzip-script/actions/workflows/test.yml/badge.svg)](https://github.com/skaji/perl-gzip-script/actions)

# NAME

App::PerlGzipScript - Gzip perl scripts to reduce their file size

# SYNOPSIS

    $ perl-gzip-script script.pl > script.pl.gz

# DESCRIPTION

App::PerlGzipScript compresses perl scripts to reduce their file size.

# EXAMPLE

Applying perl-gzip-script to [App::cpm](https://metacpan.org/pod/App%3A%3Acpm),
the size of cpm script is reduced from 731KB to 189KB.

    $ curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm > cpm

    $ perl-gzip-script cpm > cpm-gzip

    $ ls -alh cpm*
    -rw-r--r-- 1 skaji staff 731K Sep 30 06:48 cpm
    -rw-r--r-- 1 skaji staff 189K Sep 30 06:48 cpm-gzip

# COPYRIGHT AND LICENSE

Copyright 2024 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
