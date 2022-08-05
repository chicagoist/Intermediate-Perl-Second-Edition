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
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA
use YAML;
use DDP;
use Cwd;

# File 02.1.pl
# https://github.com/chicagoist/Intermediate-Perl-Second-Edition
# https://www.intermediateperl.com/
# https://www.linkedin.com/in/legioneroff/

# Read the list of files in the current directory and convert the names to
# their full path specification. Don’t use the shell or an external program
# to get the current directory. The File::Spec and Cwd modules, both of which
# come with Perl, should help. Print each path with four spaces before it and
# a newline after it.

# не работает в Windows
for (@ARGV) {
    say "    ".File::Spec->catfile( getcwd(),$_);
}


say "\n######################################";

# ANSWER
#Exercise 1 The trick in this exercise is to let the modules do all of the hard
#  work. It’s a good thing we’ve shown you how to use modules! The Cwd module
# (“cwd” is an initialism for “current working directory”) automatically
# imports the getcwd function. We don’t have to worry about how it does its
# magic, but we can be confident that it does it correctly for most major
# platforms. Once we have the current path in $cwd, we can use that as the
# first argument to the catfile method from File::Spec. The second argument
# comes from the input list to our foreach and shows up in $_:

my $cwd = getcwd;
foreach my $file ( glob( ".* *" ) ) {
    print "    ", File::Spec->catfile( $cwd, $file ), "\n";
}


