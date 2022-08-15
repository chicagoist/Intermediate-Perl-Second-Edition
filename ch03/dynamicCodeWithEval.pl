#!/usr/bin/perl -w
use v5.10;
use FindBin qw();
use lib;
#use lib "$Bin/../lib; # в подкаталоге
our $VERSION = '0.01';
# use CGI;
# use POSIX;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
BEGIN{@ARGV = map Encode::decode($_, 1), @ARGV;}
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
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
#use YAML;
use DDP;
use Cwd;

print<<'TEXT';

There’s also a second form of eval whose parameter is a string expression
instead of a block. It compiles and executes code from a string at runtime.
While this is useful and supported, it is also dangerous if any untrustworthy
data has gotten into the string. With a few notable exceptions, we recommend
you avoid eval on a string. We’ll use it a bit later, and it might show up
in other people’s code, so we’ll show how it works anyway:

eval '$sum = 2 + 2';
print "The sum is $sum\n";

TEXT
my $sum;
eval '$sum = 2 + 2';
print "The sum is $sum\n";
print "The sum is ".eval '4 + 2'."\n";

print <<'TEXT';

foreach my $operator ( qw(+ - * /) ) {
    my $result = eval "2 $operator 2";
    print "2 $operator 2 is $result\n";
 } # не работает на Windows
TEXT
# foreach my $operator ( qw(+ - * /) ) {
#     my $result = eval '2 $operator 2';
#     print "2 $operator 2 is $result\n";
# }
print 'The quotient is ', eval '5 /', "\n";
warn $@ if defined $@;
