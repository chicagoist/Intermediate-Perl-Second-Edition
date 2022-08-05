#!/usr/bin/perl
use v5.10;

use strict;
use warnings FATAL => 'all';
use Module::Find;

# wget -c https://cpan.metacpan.org/authors/id/L/LB/LBROCARD/Java-JVM-Classfile-0.20.tar.gz
# tar -xzvf Java-JVM-Classfile-0.20.tar.gz
# cd Java-JVM-Classfile-0.20/
# perl Makefile.PL
# make
# make test
# sudo make install
# OR for not root user:
# perl Makefile.PL INSTALL_BASE=/Users/home/Ginger

# To make perl look in that directory for modules, we can set the PERL5LIB
# environment variable. Perl adds those directories to its module directory
# search list. Here’s how we’d do that for the Bourne shell:
# export PERL5LIB=/Users/home/Ginger

# We can also use the lib pragma to add to the module search path,
# although this is not as friendly since not only we have to change the
# code but also because it might not be the same directory on other machines
# where we want to run the code:
# #!/usr/bin/perl
# use lib qw(/Users/home/Ginger);


# Backing up for a minute, if we found a Build.PL file instead of a
# Makefile.PL, the process is the same. These distributions
# use Module::Build
# to build and install code:
# perl Build.PL
# perl Build
# perl Build test
# perl Build install
# To install into our private directories using Module::Build,
# we add the −−install_ base parameter. We tell Perl how to find modules
# the same way we did before:
# perl Build.PL −−install_base /Users/home/Ginger



    # before install
say findsubmod Java::JVM::Classfile; # nothing

# after install
say findsubmod Java::JVM::Classfile;
# Java::JVM::Classfile::OpsJava::JVM::Classfile::Perl

eval {
    use Java::JVM::Classfile;

    my $c = Java::JVM::Classfile->new('/home/legioner/Java/STUDY/Java-How-to-Program-11ed_Linux/out/production/ch01/Painter.class');

    print "Class: " . $c->class . "\n";
    print "Methods: " . scalar(@{$c->methods}) . "\n";
    foreach my $method (@{$c->methods}) {
        print "Methods: " . $method . "\n";
    }

}

# Class: Painter
# Methods: 3

# Methods: <init> ()V [public] = Code (stack(1), locals(1))]
# Methods: start (Ljavafx/stage/Stage;)V [public] = Code (stack(3), locals(4)), Exceptions ( )]
# Methods: main ([Ljava/lang/String;)V [public, static] = Code (stack(1), locals(1))]

# Painter.java

# import javafx.application.Application;
# import javafx.fxml.FXMLLoader;
# import javafx.scene.Parent;
# import javafx.scene.Scene;
# import javafx.stage.Stage;
#
# public class Painter extends Application
#     {
#         @Override
#         public void start(Stage stage) throws Exception
#         {
#             Parent root =
#                 FXMLLoader.load(getClass().getResource("Painter.fxml"));
#
#             Scene scene = new Scene(root);
#             stage.setTitle("Painter"); // displayed in window's title bar
#             stage.setScene(scene);
#             stage.show();
#         }
#
#         public static void main(String[] args)
#         {
#             launch(args);
#         }
#     }

