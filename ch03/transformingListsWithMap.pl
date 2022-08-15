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

print <<'TEXT';

The map operator transforms one list into another. It has a syntax identical
to the grep operator’s and shares a lot of the same operational steps.
For example, it temporarily places items from a list into $_ one at a time,
and the syntax allows both the expression block forms. Our map expression is
for transformation instead of testing. The map operator evaluates our expression
in list context, not scalar context like grep. Each evaluation of the expression
gives a portion of the list that becomes the final list.
The end result is the concatenation of all individual results.
In scalar context, map returns the number of elements returned in list context.
But map should rarely, if ever, be used in anything but list context.
We start with a simple example:

my @input_numbers = (1, 2, 4, 8, 16, 32, 64);
my @result = map $_ + 100, @input_numbers;

For each of the seven items map places into $_, we get a single item to add to
the output list: the number that is 100 greater than the input number, so the
value of @result is:
TEXT
my @input_numbers = (1, 2, 4, 8, 16, 32, 64);
my @result = map $_ + 100, @input_numbers;
say join(" ", @result);

print <<'TEXT';

But we're not limited to having only one output per input. We can see what
happens when each input produces two output items:

my @result = map { $_, 3 * $_ } @input_numbers;

Now there are two items for each input item:
TEXT

my @result2 = map {$_, 3 * $_} @input_numbers;
say join(" ", @result2);

print <<'TEXT';

We can store those pairs in a hash, if we need a hash showing what number is
three times a small power of two:

my %hash = @result;

Or, without using the intermediate list from the map:

my %hash = map { $_, 3 * $_ } @input_numbers;
TEXT
eval {
    use DDP;
    my %hash = map {$_, 3 * $_} @input_numbers;
    p % hash;
};

print <<'TEXT';
That was fine for making a meaningful value for each hash key, but sometimes
we don’t care about the value because we want to use the hash as an easier
way to check that an element is in a list. In that case, we can give the keys
any value just to have the key in the hash. Using 1 is a good value to use:

my %hash = map { $_, 1 } @castaways;
my $person = 'Gilligan';
if( $hash{$person} ) {
 print "$person is a castaway.\n";
}

TEXT
my @castaways = qw(Jackson MadMax Snake);
my %hash = map { $_, 1 } @castaways;
my $person = 'Gilligan';
if( $hash{$person} ) {
    print "$person is a castaway.\n";
}else {
    print "Not exists a ".$person." in a castaway.\n";
}

%hash = map { $_, 1 } 'Gilligan';
if( $hash{$person} ) {
    print "$person is a castaway.\n";
}else {
    print "Not exists a ".$person." in a castaway.\n";
}

print<<'TEXT';

That map is pretty versatile; we can produce any number of output items for
each input item. And we don’t always need to produce the same number of output
items. We see what happens when we break apart the digits:

my @result = map { split // } @input_numbers; # 1 2 4 8 16 32 64
p @result3;

TEXT

my @result3 = map { split // } @input_numbers; # 1 2 4 8 16 32 64

p @result3;

print <<'TEXT';
my @result = map {
    my @digits = split //, $_;
    if ($digits[−1] == 4) {
        @digits;
        } else {
            (  );
            }
    } @input_numbers;

If the last digit is 4, we return the digits themselves by evaluating @digits,
which is in list context. If the last digit is not 4, we return an empty list,
effectively removing results for that particular item. Thus, we can always use
a map in place of a grep, but not vice versa.

TEXT
my @result4 = map {
    my @digits = split //, $_;
    #say "@digits";
    if ($digits[-1] == 4) {
        say "@digits";
        @digits;
    } else {
        (  );
    }
} @input_numbers; # 1 2 4 8 16 32 64

p @result4;
