use v5.10;
use FindBin qw($Bin);
use lib $Bin; # в подкаталоге
our $VERSION = '0.01';
# # use CGI;
# # use POSIX;
# # use Encode qw(decode_utf8);
# # use Encode qw(decode encode);
# #= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# # BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# # use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# # use Encode::Locale;
# # use Encode;
# # use diagnostics;
use strict;
use warnings FATAL => 'all';
# use autodie qw(:all);
# use utf8;
# binmode(STDIN, ':utf8');
# binmode(STDOUT, ':utf8');
# use Data::Dumper;
# use Bundle::Camelcade; # for Intellij IDEA
# use YAML;
# use DDP;
#
# We don’t always have to know the path ahead of time either. In the previous
# examples, we’ve hardcoded the paths. If we don’t know what those will be
# because we’re passing code around to several machines, the FindBin module,
# which comes with Perl, can help. It finds the full path to the script
# directory so we can use it to build paths:
# use FindBin qw($Bin);
# Now, in $Bin is the path to the directory that holds our script.
# If we have our libraries in the same directory, our next line can be:
# use lib $Bin;
# If we have the libraries in a directory close to the script directory,
# we put the right path components together to make it work:
# use lib "$Bin/lib";    # in a subdirectory
# use lib "$Bin/../lib"; # up one, then down into lib
