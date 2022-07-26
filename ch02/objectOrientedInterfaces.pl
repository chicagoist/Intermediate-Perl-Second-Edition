#!/usr/bin/perl -w

use v5.10;
use FindBin qw($Bin);
use lib "$Bin";
# use lib "/packages";# в подкаталоге
# our $VERSION = '0.01';
# use CGI;
# use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
#use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
#use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA
use YAML;
use DDP;

use File::Spec;
use File::Spec::Win32;
use Cwd;


my $filespec = File::Spec->catfile( "/home/legioner/","data.txt");
my $win_filespec = File::Spec::Win32->catfile( 'C:\Users\vdundukov\STUDY\C++','p.cpp');
say "";
say $filespec;
say $win_filespec;

say File::Spec->catfile( getcwd(),"whatIsInCore.pl");
say File::Spec->curdir();
