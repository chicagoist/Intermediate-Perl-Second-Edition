#!/usr/bin/perl -w
use v5.10;
use FindBin qw();
use lib;
#use lib "$Bin/../lib; # в подкаталоге
our $VERSION = '0.01';
# use CGI;
#use POSIX;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
BEGIN{@ARGV=map Encode::decode($_,1),@ARGV;}
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
#use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;
use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA
#use YAML;
use DDP;
use Cwd;

print <<'END_MESSAGE';
Intermediate Foundations.

Before we get started on the meat of the book, we want to introduce some
intermediate-level Perl idioms that we use throughout the book. These are
the things that typically set apart the beginning and intermediate Perl
programmers.

We'll also introduce the first cast of characters that we'll use in the
examples throughout the book.

END_MESSAGE

