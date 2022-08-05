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

# The PERL5LIB variable can include multiple directories separated by colons
# on Unix-like systems and semicolons on Windows-like systems (other than that,
# we’re on our own). Perl inserts all specified directories at the beginning
# of @INC. On Unix using a bash-like shell, that would be:
# export PERL5LIB=/home/skipper/perl−lib:/usr/local/lib/perl5
# On Windows, that would be:
# C:\.. set PERL5LIB="C:/lib/skipper;C:/lib/perl5"

# Extending @INC on the Command Line If Gilligan recognizes that one of the
# Skipper’s programs is missing the proper directive, Gilligan can either
# add the proper PERL5LIB variable or invoke perl directly with one or
# more −I options. For example, to invoke the Skipper’s get_us_home program,
# the command line might be something like:
# perl −I/home/skipper/perl−lib /home/skipper/bin/get_us_home

