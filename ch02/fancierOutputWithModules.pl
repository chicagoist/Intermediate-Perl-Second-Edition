#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Spreadsheet::WriteExcel;

# Create a new Excel workbook
my $workbook = Spreadsheet::WriteExcel->new('perl.xls');

# Add a worksheet
my $worksheet = $workbook->add_worksheet();

my $red_background = $workbook->add_format(
    color    => 'white',
    bg_color => 'red',
    bold     => 1,
);
my $bold = $workbook->add_format(bold => 1,);

$worksheet->write('A1', 'Hello Excel!');
$worksheet->write(0, 1, 'Hello Excel'); # in Excel's B1 cell

$worksheet->write( 0, 0, 'Colored cell', $red_background );
$worksheet->write( 0, 1, 'bold cell', $bold );

my $product_code = '01234';
$worksheet->write_string( 0, 2, $product_code );


$worksheet->write( 'A2', 35 );
$worksheet->write( 'B2', 42 );
#$worksheet->write( 'C2', '= A2 + B2');
$worksheet->write_formula('C2', '= A2 + B2');

# There’s a lot more to this module, and we should be able to quickly figure
# out its other feature by checking its documentation. We’ll also show some
# more examples as we go through the chapters on references.
