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
use Cwd;

# File 03.1.pl
# https://github.com/chicagoist/Intermediate-Perl-Second-Edition
# https://www.intermediateperl.com/
# https://www.linkedin.com/in/legioneroff/

#  Write a program that takes a list of filenames on the command line and uses
# grep to select the ones whose size is less than 1,000 bytes. Use map to
# transform the strings in this list, putting four space characters in front
# of each and a newline character after. Print the resulting list.

my $cwd = getcwd;
my @files = ();
my @bytesFiles = ();
my @result = ();

while(<*>) {
    next if /^\s*$/;
    push @files, File::Spec->catfile( $cwd, $_ );
    @bytesFiles = grep {
        $_ if 1000 >= -s $_;
    } @files;

    if(@bytesFiles != @result) {
        push @result, map {"    " . $_ . "\n"} @bytesFiles;
    }
}

print @result;


# Exercise 1
# Here’s one way to do it. The command line arguments show up in the special
# array @ARGV so we use that for our input list. The file test operator −s
# works on $_ by default, and that’s the current element that grep tests.
# All of the files with sizes in bytes smaller than 1,000 bytes end up in
# @smaller_than_1000. That array becomes the input for the map, which takes
# each element and returns it with spaces tacked on the front and a newline
# on the end:

#   my @smaller_than_1000 = grep { −s < 1000 } @ARGV;
#   print map { "    $_\n" } @smaller_than_1000;

# Typically, we’ll do that without the intermediate array though:

#   print map { "    $_\n" } grep { −s < 1000 } @ARGV;
