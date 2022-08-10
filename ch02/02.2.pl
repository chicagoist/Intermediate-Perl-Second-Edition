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

# File 02.2.pl
# https://github.com/chicagoist/Intermediate-Perl-Second-Edition
# https://www.intermediateperl.com/
# https://www.linkedin.com/in/legioneroff/

# Install the local::lib module  and  use  it  when  you  install Module::CoreList (or another module if you like).
# Write a program that reports the name and first release date for all the modules in Perl v5.14.2.
# Read the documentation for local::lib to see if it has special installation instructions.

use FindBin;
use local::lib "$FindBin::Bin/..";
use lib "$FindBin::Bin/../lib";
use Module::CoreList;

#print $Module::CoreList::version{5.014002}{all};
my (%nameOfModules) = sort keys %{$Module::CoreList::version{5.014002}};
my $max_length = 0;

foreach my $nameOfModule (sort keys %nameOfModules) {
    $max_length = length $nameOfModule if length $nameOfModule > $max_length;

    printf("%*s %s\n",-$max_length,$nameOfModule,Module::CoreList->first_release($nameOfModule));
}


#       cd ~/mydir1
#     perl -Mlocal::lib=./
#       eval $(perl -Mlocal::lib=./)  ### To set the environment for this shell alone
# printenv                      ### You will see that ~/mydir1 is in the PERL5LIB
#     perl -MCPAN -e install ...    ### whatever modules you want
#         cd ../mydir2


