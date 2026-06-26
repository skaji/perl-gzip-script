package App::PerlGzipScript v0.0.3;
use v5.42;

use File::Basename ();
use File::Slurper ();
use File::Temp ();
use Getopt::Long::Parser;
use Gzip::Libdeflate;

our $TRIAL = 0;

my $HELP = <<'EOF';
Usage: perl-gzip-script [options] SCRIPT

Options:
  -i, --in-place  send output back to files, not stdout.
  -s, --shebang   shebang, default: "#!/usr/bin/env perl"
  -h, --help      show this help
  -v, --version   show version

Examples:
  $ perl-gzip-script script.pl > script.pl.gz
  $ perl-gzip-script -i script.pl
EOF

sub new ($class) {
    bless { in_place => 0, shebang => '#!/usr/bin/env perl' }, $class;
}

sub parse_options ($self, @argv) {
    my $parser = Getopt::Long::Parser->new(config => [qw(no_auto_abbrev no_ignore_case bundling)]);
    $parser->getoptionsfromarray(\@argv,
        "i|in-place" => sub (@) { $self->{in_place} = 1 },
        "s|shebang=s" => sub ($, $v) { $self->{shebang} = $v },
        "h|help" => sub (@) { die $HELP },
        "v|version" => sub (@) { say $self->VERSION; exit },
    ) or return;
    my $script = shift @argv;
    (1, $script);
}

sub run ($self, @argv) {
    my ($ok, $script) = $self->parse_options(@argv) or return 1;
    if (!$ok) {
        return 1;
    }
    if (!$script) {
        die "Need SCRIPT argument.\n";
    }

    my $out = $self->{in_place} ? File::Temp->new(DIR => File::Basename::dirname($script)) : \*STDOUT;

    $out->say($self->{shebang});
    $out->print(<<~'EOF');
    use IO::Uncompress::Gunzip ();
    IO::Uncompress::Gunzip::gunzip(\*DATA, \my $script, AutoClose => 1, BinModeOut => 1) or die $IO::Uncompress::Gunzip::GunzipError;
    eval '#line 1 "' . __FILE__ . "\"\n" . $script;
    die $@ if $@;
    __DATA__
    EOF

    my $content = File::Slurper::read_binary($script);
    my $content_gzip = Gzip::Libdeflate->new(level => 12)->compress($content) or die;
    $out->print($content_gzip);

    if (!$self->{in_place}) {
        return 0;
    }

    $out->close;
    my $mode = (stat $script)[2];
    chmod $mode, $out->filename;
    rename $out->filename, $script or die $!;
    $out->unlink_on_destroy(0);
    return 0;
}

__END__

=encoding utf-8

=head1 NAME

App::PerlGzipScript - Gzip perl scripts to reduce their file size

=head1 SYNOPSIS

  $ perl-gzip-script script.pl > script.pl.gz

=head1 DESCRIPTION

App::PerlGzipScript compresses perl scripts to reduce their file size.

=head1 EXAMPLE

Applying perl-gzip-script to L<App::cpm>,
the size of cpm script is reduced from 731KB to 189KB.

  $ curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm > cpm

  $ perl-gzip-script cpm > cpm-gzip

  $ ls -alh cpm*
  -rw-r--r-- 1 skaji staff 731K Sep 30 06:48 cpm
  -rw-r--r-- 1 skaji staff 189K Sep 30 06:48 cpm-gzip

=head1 ARTIFACT ATTESTATIONS

GitHub Artifact Attestations are generated for release tarballs uploaded to
CPAN. If you care about provenance for the uploaded tarballs, see:

L<https://github.com/skaji/perl-gzip-script/attestations>

=head1 COPYRIGHT AND LICENSE

Copyright 2024 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
