#!/usr/bin/perl
use v5.10;

use strict;
use warnings FATAL => 'all';

# Core, or the Standard Library or Distribution or Version, is the set of
# modules and add-ons that comes with the standard distribution
# (the one we’d download from CPAN). When people talk about “core,”
# they are most often talking about the set of modules that we can count
# on any particular Perl having, usually so we can be sure that someone
# using our program doesn’t need to install extra modules.


use Module::CoreList;
print $Module::CoreList::version{5.01400}{CPAN}; # 1.9600

Module::CoreList->first_release('Module::Build'); # 5.009004

