#!/usr/bin/perl -w

use v5.10;
use FindBin qw($Bin);
use lib "$Bin";
# use lib "/packages";# в подкаталоге
# our $VERSION = '0.01';
use CGI;
use POSIX;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
use utf8::all 'GLOBAL';
use Encode::Locale;
use Encode;
use diagnostics;


use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA
use YAML;
use DDP;

#use File::Basename;

my $some_full_path = '/home/legioner/Perl_Projects/Intermediate-Perl-Second-Edition/functionalInterfaces.pl';
my $windows_some_full_path = 'C:\Users\vdundukov\STUDY\C++\p.cpp';
use File::Basename;
fileparse_set_fstype("MSWin32");
my $basename = basename( $some_full_path );
my $dirname  = File::Basename::dirname(  $some_full_path );

my $win_basename = basename( $windows_some_full_path );
my $win_dirname  = File::Basename::dirname(  $windows_some_full_path );
my $win_fileparse  = fileparse(  $windows_some_full_path );


say "";
say "basename = " . $basename;
say "dirname = " . $dirname;
say "";
say "win_basename = " . $win_basename;
say "win_dirname = " . $win_dirname;
say "win_fileparse = " . $win_fileparse;
