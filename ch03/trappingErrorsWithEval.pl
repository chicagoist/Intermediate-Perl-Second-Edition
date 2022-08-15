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

my $average = 0;
my $count = 0;
my $total = 1;
eval {
  $average =  $total / $count; # divide by zero?
    $average++;
}; print "Continuing after error: $@" if defined $@;

say $average; # 0


print<<'TEXT';
The block is a true block and may include lexical variables (“my” variables)
and any other arbitrary statements. As a function, eval has a return value
much like a subroutine's (the last expression evaluated, or a value returned
early by the return keyword). If the code in the block fails, it returns no
value; this gives undef in scalar context, or an empty list in list context.
Thus, another way to calculate an average safely looks like this:
$block_average = eval {$total / $count };# undef?

TEXT

my $block_average = 1;
$block_average = eval {$total / $count };# divide by zero?
print "Continuing after block_error: $@" if defined $@;
p $block_average; # undef

print <<'TEXT';
For simple operations, a straight eval is fine. For reasons we won’t go into,
correctly handling complex situations can be tricky. Fortunately for us, v5.14
fixed some of these problems, or we can use the the Try::Tiny module
(available on CPAN):

use Try::Tiny;
my $average = try { $total / $count } catch { "NaN" };

Many of these weird edge cases were fixed in v5.14.
TEXT

eval{
    use Try::Tiny;
    my $averageTiny = try { $total / $count } catch { "NaN" }; # undef
    p $averageTiny;
};
