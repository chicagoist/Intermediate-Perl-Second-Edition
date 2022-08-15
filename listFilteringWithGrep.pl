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

print <<'END_MESSAGE';


The grep operator takes a 'testing expression' and a list of values.
It takes each item from the list in turn and places it into the $_ variable.
It then evaluates the testing expression in scalar context.
If the expression evaluates to a true value, grep passes $_ on to the output
list:
my @lunch_choices = grep is_edible($_), @gilligans_possessions ;

END_MESSAGE

my @input_numbers = (1, 2, 4, 8, 16, 32, 64);
print <<'TEXT';
In list context, the grep operator returns a list of all such selected
items. In scalar con-text, grep returns the number of selected items:

my @results = grep $_ > 10, @input_numbers;
my $count = grep $_ > 10, @input_numbers;
TEXT
my @results = grep $_ > 10, @input_numbers;
my $count = grep $_ > 10, @input_numbers;
say join(" ", @results); # 16 32 64
say join(" ", $count); # 3

print <<'TEXT';

The result is 16, 32, and 64. This uses an explicit reference to $_.
Here's an example of an implicit reference to $_ from the pattern
match operator:
my @end_in_4 = grep /4$/, @input_numbers;
TEXT
my @end_in_4 = grep /4$/, @input_numbers;
say join(" ",@end_in_4);


print <<'TEXT';

If the testing expression is complex, we can hide it in a subroutine:
my @odd_digit_sum = grep digit_sum_is_odd($_), @input_numbers;

TEXT
my @odd_digit_sum = grep digit_sum_is_odd($_), @input_numbers;
sub digit_sum_is_odd {
    my $input = shift;
    my @digits = split //, $input;  # Assume no nondigit characters
    my $sum;
    $sum += $_ for @digits;
    return $sum % 2;
}

print <<'TEXT';
say join(" ", @odd_digit_sum);
Now we get back the list of 1, 16, and 32. These numbers have a digit sum with
a remainder of '1' in the last line of the subroutine, which counts as true.
TEXT
say join(" ", @odd_digit_sum);

print <<'TEXT';

Like the expression form,
grep temporarily places each element of the input list into $_.
Next, it evaluates the entire block of code. The last evaluated expression
in the block is the testing expression, and like all testing expressions,
it’s evaluated in scalar context. Because it’s a full block, we can
introduce variables that are scoped to the block. We rewrite that last
example to use the block form:

my @odd_digit_SUM = grep {
    my $input = $_;
    my @digits = split //, $input;   # Assume no nondigit characters
    my $sum;
    $sum += $_ for @digits;
    $sum % 2;
} @input_numbers;

say join(" ", @odd_digit_SUM);
TEXT
my @odd_digit_SUM = grep {
    my $input = $_;
    my @digits = split //, $input;   # Assume no nondigit characters
    my $sum;
    $sum += $_ for @digits;
    $sum % 2;
} @input_numbers;
say join(" ", @odd_digit_SUM);

print <<'TEXT';

Note the two changes: the input value comes in via $_ rather than an
argument list, and we removed the keyword return. We would have been
wrong to keep the return be-cause we’re no longer in a separate
subroutine: just a block of code. We can optimize a few things out of
that routine since we don’t need the intermediate variables:

my @odd_digit_suM = grep {
    my $sum;
    $sum += $_ for split //;
    $sum % 2;
} @input_numbers;

say join(" ", @odd_digit_suM);
TEXT
my @odd_digit_suM = grep {
    my $sum;
    $sum += $_ for split //;
    $sum % 2;
} @input_numbers;
say join(" ", @odd_digit_suM);

print <<'TEXT';

We can do whatever we like in that grep block. Suppose we have a list of URLs
in @links and we want to know which ones are no longer good. We can send
that list of links through the grep, check them with HTTP::SimpleLinkChecker
(available on CPAN), and pass through only the links that don’t have an error:

use HTTP::SimpleLinkChecker qw(check_link);

my @good_links = grep {check_link( $_ );
    ! $HTTP::SimpleLinkChecker::ERROR;
    } @links;

TEXT
use HTTP::SimpleLinkChecker;
my @links = qw(https://www.ruptly.r https://www.rt.com https://russian.rt);

my @good_links = grep {
    HTTP::SimpleLinkChecker::check_link( $_ );
    ! $HTTP::SimpleLinkChecker::ERROR;
} @links;

say join(" ", @good_links);
