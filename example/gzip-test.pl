#!/usr/bin/env perl
use v5.16;
use IO::Uncompress::Gunzip ();
IO::Uncompress::Gunzip::gunzip \*DATA, \my $script, AutoClose => 1 or die $IO::Uncompress::Gunzip::GunzipError;
eval '#line 1 "' . __FILE__ . "\"\n" . $script;
die $@ if $@;
__DATA__
�      �SV�/-.�O���O�+S(H-��*-NU(3�34�3���2�ҋ���\�̼��< $��������W���Z����\R���`��d��Q�j��
(ܘ<$u@I� ��h��X��	�WH�/R0P��SPQ	[s �<���   