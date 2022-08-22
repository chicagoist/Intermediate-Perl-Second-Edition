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
use File::Basename;


# File 03.2.pl
# https://github.com/chicagoist/Intermediate-Perl-Second-Edition
# https://www.intermediateperl.com/
# https://www.linkedin.com/in/legioneroff/

#  Write a program that asks the user to enter a pattern (regular expression).
# Read this as data from standard input; don’t get it from the command line
# arguments. Report a list of files in some hardcoded directory
# (such as "/etc" or 'C:\\Windows') whose names match the pattern.
# Repeat this until the user enters an empty string instead of a pattern.
# The user should not type the slashes traditionally used to delimit pattern
# matches in Perl; the input pattern is delimited by the trailing newline.
# Ensure that a faulty pattern, such as one with unbalanced parentheses,
# doesn't crash the program.

my $directory = '/var/log';
print "Enter pattern: ";
my $pattern = <STDIN>;
chomp($pattern);
if("MSWin32" eq fileparse_set_fstype()) {
 eval {
     my $username = Win32::LoginName();
     say ">$username<";
     $directory = 'C:\Users\\' . $username . '\AppData\Local\Packages\TheDebianProject'
         . '.DebianGNULinux_76v4gfsz19hv4\LocalState\rootfs\var\log';
 }
}
opendir my $dh, $directory || die "Can't open $directory: $!";
while(readdir $dh) {
    print map {"$_\n"} grep {eval {/$pattern/} && $_ ne '.' and $_ ne '..'} readdir $dh;
    last if closedir $dh;
}


# ANSWER
# We chose to use our home directory as the hardcoded directory. When we call
# chair without an argument, it goes to our home directory (so this is one of
# the few places where Perl doesn't use $_ as the default). After that, an
# infinite while loop keeps our code running, at least until  we can’t satisfy
# the condition to last, which breaks us out of the loop. Look at the condition
# carefully: we don’t test for truth.
# What would happen if we wanted to find all the files with a 0 in them?
# We look for defined values with a nonzero length, so undef (end of input)
# and the empty string (hitting enter) stop the loop. Once we have our regular
# expression, we do the same thing we did in the previous answer. This time,
# we use the result of glob as the input list and a pattern match inside the
# grep. We wrap an eval {} around the pattern match in case the pattern doesn’t
# compile (for instance, it has an unmatched parenthesis or square bracket):

# chdir; # go to our home directory
# while( 1 ) {
#    print "Please enter a regular expression> ";
#   chomp( my $regex = <STDIN> );
#    last unless( defined $regex && length $regex );
#    print map { "    $_\n" }
#    grep { eval{ /$regex/ } }
#    glob( ".* *" );
# }
