package Abebooks {
    use v5.10;
    use FindBin qw($Bin);
    use lib "$Bin"; # в подкаталоге
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
    #use autodie qw(:all);
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    #use Data::Dumper;
    #use Bundle::Camelcade; # for Intellij IDEA
    #use YAML;
    use DDP;

    # use Exporter qw(import);
    # our @EXPORT = qw(sound default_color);
    # our @EXPORT_OK = qw(
    # );
    #
    # our %EXPORT_TAGS = (
    #     all => [ @EXPORT, @EXPORT_OK ],
    #     sound => [ qw( sound ) ],
    #     color => [ qw(default_color) ],
    # );

    use Moose;
    use MooseX::Privacy;
    #use Moose::Role;

    use Moose::Util::TypeConstraints;
    use namespace::autoclean;
    use HTTP::Request::Common;
    use LWP::UserAgent;
    use LWP::UserAgent::JSON;
    #use HTTP::Request::JSON;
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
                say 'return';
                return to_json($respond_adebooks{_content});
            } else
            {
                say 'die';
                eval {
                    die $uaGetPrice && %respond_adebooks;
                };
            }
        } $respond_adebooks{_content};
    };

    private_method __get_recomendations => sub {

        my $payload = shift;
        p %{$payload};
        my $header = [ 'Content-Type' => 'application/json; charset=UTF-8' ];
        my $encoded_data = encode_json($payload);
        say '$payload = ', $payload->{pageId};
        p $encoded_data;
        my $url = 'https://www.abebooks.com/servlet/RecommendationsApi';
        my $uaRecomendations = LWP::UserAgent->new;
        my $reqGetRecomendations = GET 'https://www.abebooks'
            . '.com/servlet/RecommendationsApi?pageId='
            . $payload->{pageId}
            . '&itemIsbn13='
            . $payload->{itemIsbn13},
            Content_Type => 'application/json; charset=UTF-8';

        my $respondRecomendations = $uaRecomendations->request($reqGetRecomendations);

        #p $respondRecomendations;
            map {
                if ($_ =~ /"slotName":.*/)
                {
                    say 'return';
                    say $respondRecomendations->{_content};
                    return to_json($respondRecomendations->{_content});
                } else
                {
                    say 'die';
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

    sub getRecommendationsByISBN
    {
        my $self = shift;
        my $isbn = shift;

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


    # sub getPricingDataByISBN {
    #
    # }


    # with 'Animal'; # for Class but not for Role

    #requires qw(sound default_color); # only for Role

    # enum 'ColorStr' => [qw( white brown black grey spotted)];
    #
    # has 'name' => (is => 'rw');
    # has 'color' => (
    #     is => 'ro',
    #     isa => 'ColorStr',
    #     writer => '_private_set_color',
    #     default => sub { shift->default_color }
    # );
    #
    # sub speak_print {
    #     my $self = shift;
    #     print $self->name, " goes ", $self->sound, "\n";
    # }
    #
    #
    # sub sound
    # {'neigh'}
    # sub default_color
    # {'brown'}

    __PACKAGE__->meta->make_immutable; # or commit for Role

    1;
}
__END__


/*
# Below is stub documentation for your module. You'd better edit it!
# =head1 NAME
# abebooks - Perl модуль
# =head1 SYNOPSIS
#   #use FindBin qw($Bin);
#   #use lib '$Bin/abebooks/lib'; # в подкаталоге
#   #use abebooks;
# =head1 DESCRIPTION
# Документация к модулю Horse, созданного с помощью h2xs.
# Этот модуль определяет класс Horse. Для работы модуля необходим ролевой
# Animal. Модуль Horse использует ООП модуля Moose. Достаточно и необходимо объявить
# модуль Horse через use Horse;
# Модуль содержит функции 'sound' и 'default_color'.
# Функция 'sound' возвращает значение, подходящее для определения звука данного класса.
# Функция 'default_color' возвращает значение цвета по умолчанию.
# =head2 EXPORT
#   #use FindBin qw($Bin);
#   #use lib '$Bin/abebooks/lib'; # в подкаталоге
#   #use abebooks;
# =head1 SEE ALSO
# Mention other useful documentation such as the documentation of
# related modules or operating system documentation (such as man pages
# in UNIX), or any relevant external documentation such as RFCs or
# standards.
# https://metacpan.org/pod/Moose
# https://metacpan.org/pod/Moose::Role
# =head1 AUTHOR
# A. U. Thor, E<lt>legioner@E<gt>
# =head1 COPYRIGHT AND LICENSE
# Copyright (C) 2022 by A. U. Thor
# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself, either Perl version 5.34.0 or,
# at your option, any later version of Perl 5 you may have available.
# =cut
*/
