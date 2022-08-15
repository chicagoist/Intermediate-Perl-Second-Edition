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
# foreach my $files ( glob( ".* *" ) ) {
#     #print "    ", File::Spec->catfile( $cwd, $file ), "\n";
#     print "$files\n";
# }
my @files = ();

while(<*>) {
    next if /^\s*$/;
    #print "    ", File::Spec->catfile( $cwd, $_ ), "\n";

    push @files,"    ".File::Spec->catfile( $cwd, $_ ), "\n";
}

print join(" ",@files);
