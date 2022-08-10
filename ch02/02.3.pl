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
#use Bundle::Camelcade; # for Intellij IDEA
#use YAML;
#use DDP;
use Cwd;

# File 02.3.pl
# https://github.com/chicagoist/Intermediate-Perl-Second-Edition
# https://www.intermediateperl.com/
# https://www.linkedin.com/in/legioneroff/

# Parse the International Standard Book Number from the back of this book (9781449393090).
# Install the Business::ISBN module from CPAN and use it to extract the group code and the
# publisher code from the number.

use FindBin;
use local::lib "$FindBin::Bin/..";
use lib "$FindBin::Bin/../lib";
use Business::ISBN;

my $isbn13 = Business::ISBN->new('9781449393090');
print join(" ",sort keys %{$isbn13});
say $isbn13->group_code;
say $isbn13->publisher_code;


# perl 02.3.pl 9781449393090
my $isbn = Business::ISBN->new( $ARGV[0] );
print "ISBN is "         . $isbn->as_string      . "\n";
print "Country code:   " . $isbn->group_code   . "\n";
print "Publisher code: " . $isbn->publisher_code . "\n";
