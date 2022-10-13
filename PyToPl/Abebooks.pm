package Abebooks {
    use v5.10;
    use FindBin qw($Bin);
    use lib "$Bin";
    our $VERSION = '0.01';
    use strict;
    use warnings FATAL => 'all';
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');


    use DDP;
    use Moose;
    use MooseX::Privacy;
    use namespace::autoclean;
    use HTTP::Request::Common;
    use LWP::UserAgent;
    use LWP::UserAgent::JSON;
    use JSON;

    private_method __get_price => sub {
        my $payload = shift;

        my $url = 'https://www.abebooks.com/servlet/DWRestService/pricingservice';
        my $uaGetPrice = LWP::UserAgent::JSON->new;
        my $reqGetPrice = POST $url,
            Content_Type => 'application/x-www-form-urlencoded; charset=UTF-8',
            Content      => [ $payload ];
        my %respond_adebooks = %{$uaGetPrice->request($reqGetPrice)};

        map {
            if ($_ =~ /"success":true/)
            {
                #say to_json($respond_adebooks{_content});
                return to_json($respond_adebooks{_content});
            } else
            {
                eval {
                    die $uaGetPrice && %respond_adebooks;
                };
            }
        } $respond_adebooks{_content};
    };

    private_method __get_recomendations => sub {
        my $payload = shift;

        my $url = 'https://www.abebooks.com/servlet/RecommendationsApi';
        my $uaRecomendations = LWP::UserAgent->new;
        my $reqGetRecomendations = GET 'https://www.abebooks'
            . '.com/servlet/RecommendationsApi?pageId='
            . $payload->{pageId}
            . '&itemIsbn13='
            . $payload->{itemIsbn13},
            Content_Type => 'application/json; charset=UTF-8';

        my $respondRecomendations = $uaRecomendations->request($reqGetRecomendations);

        map {
            if ($_ =~ /"slotName":.*/)
            {
                #say to_json($respondRecomendations->{_content});
                return to_json($respondRecomendations->{_content});
            } else
            {
                eval {
                    die $uaRecomendations && $respondRecomendations;
                };
            }
        } $respondRecomendations->{_content};
    };

    sub getPriceByISBN
    {
        my $self = shift;
        my $isbn = shift;
        chomp($isbn);
        # """
        # Parameters
        # ----------
        # isbn (int) - a book's ISBN code
        # """
        my %payload = (
            action    => 'getPricingDataByISBN',
            isbn      => $isbn,
            container => "pricingService-{}.$isbn"
        );

        __get_price(\%payload);

    }

    sub getPriceByAuthorTitle
    {
        my ($self, $author, $title) = @_;
        chomp($author);
        chomp($title);
        # """
        # Parameters
        # ----------
        # author (str) - book author
        # title (str) - book title
        # """
        my %payload = (
            action    => 'getPricingDataForAuthorTitleStandardAddToBasket',
            an        => $author,
            tn        => $title,
            container => 'oe-search-all'
        );

        __get_price(\%payload);
    }

    sub getPriceByAuthorTitleBinding
    {
        my ($self, $author, $title, $binding) = @_;
        my $container;
        chomp($author);
        chomp($title);
        chomp($binding);

        # """
        # Parameters
        # ----------
        # author (str) - book author
        # title (str) - book title
        # binding(str) - one of 'hard', or 'soft'
        # """

        if ($binding eq 'hard')
        {
            $container = 'priced-from-hard'
        } elsif ($binding eq 'soft')
        {
            $container = 'priced-from-soft'
        } else
        {
            die 'Invalid parameter. Binding must be "hard" or "soft"' if
                defined $@;
        }

        my %payload = (
            action    => 'getPricingDataForAuthorTitleBindingRefinements',
            an        => $author,
            tn        => $title,
            container => $container
        );

        __get_price(\%payload);

    }



    sub getRecommendationsByISBN
    {
        my $self = shift;
        my $isbn = shift;
        chomp($isbn);

        # """
        # Parameters
        # ----------
        # isbn (int) - a book's ISBN code
        # """

        my %payload = (
            pageId     => 'plp',
            itemIsbn13 => $isbn
        );
        return __get_recomendations(\%payload);
    }

    __PACKAGE__->meta->make_immutable; # or commit for Role

    1;
}
__END__
=head1 NAME
Abebooks - Perl module
=head1 SYNOPSIS
    use FindBin qw($Bin);
    se lib "$Bin";
    use Moose;
    use MooseX::Privacy;
    use HTTP::Request::Common;
    use LWP::UserAgent;
    use LWP::UserAgent::JSON;
    use JSON;
    use Abebooks;
=head1 DESCRIPTION
Documentation for the AbeBooks module created using H2XS.
This module determines the class Abebooks. To work this module, you need to
establish dependencies: Moose, MooseX::Privacy, HTTP::Request::Common,
LWP::UserAgent, LWP::UserAgent::JSON, JSON;

The Abebooks module uses the Moose OOP module. Enough and necessary to declare
Abebooks module using:

use Abebooks;

The module contains the functions '__get_price' and '__get_recomendations' -
they are private. These functions return values in the JSON standard.

my $ade_script = Abebooks->new();
$ade_script->getPriceByISBN(9781449393090);
$ade_script->getRecommendationsByISBN(9781449393090);
$ade_script->getPriceByAuthorTitle('Schwartz, Randal L.', 'Learning Perl:');
$ade_script->getPriceByAuthorTitleBinding('Schwartz, Randal L.', 'Learning '.'Perl:', 'hard');
$ade_script->__get_price();

=head1 SEE ALSO
Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.
https://metacpan.org/pod/Moose
https://metacpan.org/pod/Moose::Role
https://metacpan.org/pod/MooseX::Privacy
https://metacpan.org/pod/LWP::UserAgent::JSON
https://metacpan.org/pod/LWP::UserAgent
https://metacpan.org/pod/HTTP::Request::Common
https://metacpan.org/pod/JSON
=head1 AUTHOR
Chicagoist, E<lt>z7t35gbba@mozmail.comE<gt>
=head1 COPYRIGHT AND LICENSE
Copyright (C) 2022 by Chicagoist
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.34.0 or,
at your option, any later version of Perl 5 you may have available.
=cut
