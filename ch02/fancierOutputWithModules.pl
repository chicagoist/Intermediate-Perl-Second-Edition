#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Spreadsheet::WriteExcel;

# Create a new Excel workbook
my $workbook = Spreadsheet::WriteExcel->new('perl.xls');

# Add a worksheet
my $worksheet = $workbook->add_worksheet();

$worksheet->write( 'A1', 'Hello Excel!' );
