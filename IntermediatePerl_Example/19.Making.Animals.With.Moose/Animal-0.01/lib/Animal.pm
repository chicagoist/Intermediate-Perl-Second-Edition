package Animal;
use Moose::Role;
use namespace::autoclean;

our $VERSION = 0.01;

requires qw( sound default_color );

has 'name'  => ( is => 'rw' );
has 'color' => (
	is => 'rw',
	default => sub { shift->default_color }
	);

sub speak {
	my $self = shift;
	print $self->name, " goes ", $self->sound, "\n";
	}

1;

__END__

=encoding utf8

=head1 NAME

Animal - a base class for Animals

=head1 SYNOPSIS

	package Badger;
	use Moose;
	use namespace::autoclean;
	
	with 'Animal';
	
	...
	
	__PACKAGE__−>meta−>make_immutable;

	1;
	
=head1 DESCRIPTION

=over 4

=item * speak

Say something.

=back

=head1 SOURCE AVAILABILITY

This code comes from I<Intermediate Perl> and can be found at the
Downloads section of http://www.intermediateperl.com/.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2011-2013 brian d foy

=cut
