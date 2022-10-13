#!/usr/bin/perl
use v5.10;
use FindBin qw($Bin);
use lib $Bin; # в подкаталоге
our $VERSION = '0.01';
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
use Cwd;
use File::Basename;

use Abebooks;

my $ade_script = Abebooks->new();
$ade_script->getPriceByISBN(9781449393090);
$ade_script->getRecommendationsByISBN(9781449393090);
$ade_script->getPriceByAuthorTitle('Schwartz, Randal L.', 'Learning Perl:');
$ade_script->getPriceByAuthorTitleBinding('Schwartz, Randal L.', 'Learning '.'Perl:', 'hard');
$ade_script->__get_price();
