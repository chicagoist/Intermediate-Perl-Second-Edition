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
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
# use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA
use YAML;
use DDP;


print("A More Typical Object-Oriented Module: Math::BigInt\n");

use Math::BigInt;
#use Tcl;
use Tk;


my $value = Math::BigInt->new(2); # start with 2
$value->bpow(10);               # take 2**10
my $tkValue = $value->bstr;         # print it out
say $tkValue;
my $mw = MainWindow->new;
$mw->title("Hello World");
$mw->Button(-text => $tkValue, -command => sub { exit })->pack;
MainLoop;























