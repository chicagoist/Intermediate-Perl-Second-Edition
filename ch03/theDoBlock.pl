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
use utf8::all 'GLOBAL';
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
use YAML;
use DDP;

print<<'TEXT';

The do block is one powerful but overlooked feature of Perl. It provides a way
to group statements as a single expression that we can use in another expression.
It’s almost like an inline subroutine. As with subroutines, the result of do is
the last evaluated expression. First, consider a bit of code to assign one of
three possible values to a variable. We declare $bowler as a lexical variable,
and we use an if−elsif−else structure to choose which value to assign. We end
up typing the variable name four times to get a single assignment:

my $bowler;
if( ...some condition... ) {
    $bowler = 'Mary Ann';
} elsif( ... some condition ... ) {
    $bowler = 'Ginger';
    } else {
    $bowler = 'The Professor';
}

However, with do, we only have to use the variable name once. We can assign to
it at the same time that we declare it because we can combine everything else
in the do as if it were a single expression:

my $bowler = do {
if( ... some condition ... )    { 'Mary Ann' }
elsif( ... some condition ... ) { 'Ginger' }
else                            { 'The Professor' }
};

TEXT
my $filename = 'listOperators.pl';
my $file_contents = do {
    local $/;
    local @ARGV = ( $filename );
    <>
};

p $file_contents;
eval $file_contents;
