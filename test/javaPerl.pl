#!/usr/bin/perl -w

use v5.10;
use FindBin qw($Bin);
use lib "$Bin";
# use lib "/packages";# в подкаталоге
# our $VERSION = '0.01';
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

use Inline Java => <<'END_OF_JAVA_CODE', package => 'ok::test';

   class Pod_alu {
      public Pod_alu(){
      }

      public int add(int i, int j){
         return i + j ;
      }

      public int subtract(int i, int j){
         return i - j ;
      }
   }


END_OF_JAVA_CODE

use Inline Java => <<'END_OF_JAVA_CODE', package => 'test::test';
import java.lang.*;
   class Pod_sum {
      public Pod_sum(){
      System.out.println("Java from Perl 666!");
      }

      public int add(int i, int j){
         return i + j ;
      }

      public int subtract(int i, int j){
         return i - j ;
      }

      public String outPrint () {
       String str = "Java from Perl !";
       return str;
      }
   }

END_OF_JAVA_CODE

use Inline Java => <<'END_OF_JAVA_CODE', package => 'gfl::test';

import java.util.Objects;
import java.lang.*;

class GFL {

  public GFL () {
  System.out.println("Java from Perl GFL!");
  }

    public void testGFL() {

        System.out.println();
        ODTask task1 = new ODTask();
        task1.setWord("HelloWorld");
        task1.setId(666);
        System.out.println("(ODTask class) task1.getWord = " + task1.getWord());
        System.out.println("(ODTask class) task1.getId = " + task1.getId());
        System.out.println();

        ODTask task2 = new ODTask();
        task2.setId(666);
        task2.setWord("HelloWorld");
        System.out.println("(ODTask class) task2.getWord = " + task2.getWord());
        System.out.println("(ODTask class) task2.getId = " + task2.getId() + "\n");

        ODTaskDuoble taskDouble = new ODTaskDuoble();
        taskDouble.setWord("HelloWorld");
        taskDouble.setId(666);
        System.out.println("(ODTaskDuoble class) taskDouble.getWord = " + taskDouble.getWord());
        System.out.println("(ODTaskDuoble class) taskDouble.getId = " + taskDouble.getId());
        System.out.println();


        System.out.print("(ODTask class) task1.equals(task2) = ");
        System.out.println(task1.equals(task2));
        System.out.println();
        System.out.print("(ODTask class != ODTaskDuoble class)  task1.equals(taskDouble) = ");
        System.out.println(task1.equals(taskDouble));
        System.out.println();
        System.out.print("(ODTask class) Objects.equals(task1.hashCode(),task2.hashCode()) = ");
        System.out.println(Objects.equals(task1.hashCode(),task2.hashCode()));
        System.out.println();
        System.out.print("(ODTask class == ODTaskDuoble class) Objects.equals(task1.hashCode(),taskDouble.hashCode())) = ");
        System.out.println(Objects.equals(task1.hashCode(),taskDouble.hashCode()));
        System.out.println();
        System.out.print("(ODTask class != ODTaskDuoble class) Objects.equals(task1,taskDouble) = ");
        System.out.println(Objects.equals(task1,taskDouble));
        System.out.println();


        if(task1.hashCode() == task2.hashCode()) {
            System.out.println("EQALS! task1.hashCode() == task2.hashCode()");
            System.out.println("ODTask class task1 hashCode = " + task1.hashCode());
            System.out.println("ODTask class task2 hashCode = " + task2.hashCode());
        }else {
            System.out.println("NOT EQALS! task1.hashCode() == task2.hashCode()");
            System.out.println("ODTask class task1 hashCode = " + task1.hashCode());
            System.out.println("ODTask class task2 hashCode = " + task2.hashCode());
        }
        System.out.println();

        if(task1.hashCode() == taskDouble.hashCode()) {
            System.out.println("EQALS! task1.hashCode() == taskDouble.hashCode()");
            System.out.println("ODTaskDuoble class task1 hashCode = " + task1.hashCode());
            System.out.println("ODTaskDuoble class taskDouble hashCode = " + taskDouble.hashCode());
        }else {
            System.out.println("NOT EQALS! task1.hashCode() == taskDouble.hashCode()");
            System.out.println("ODTaskDuoble class task1 hashCode = " + task1.hashCode());
            System.out.println("ODTaskDuoble class taskDouble hashCode = " + taskDouble.hashCode());
        }
        System.out.println();
    }
}

class ODTask {

    private String word = new String();
    private int id;

    public ODTask() {
        setWord("default");
        setId(0);
    }

    public ODTask(String args, Integer id) {
        this.word = args;
        this.id = id;
    }


    public String getWord() {

        return this.word;
    }

    public void setWord(String word) {

        this.word = word;
    }

    public Integer getId() {

        return this.id;
    }

    public void setId(Integer id) {

        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ODTask odtask = (ODTask) o;
        return Objects.equals(word, odtask.word) && Objects.equals(id, odtask.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(word, id);
    }
}

class ODTaskDuoble {

    private String word = new String();
    private int id;


    public ODTaskDuoble() {
        setWord("default");
        setId(0);

    }

    public ODTaskDuoble(String args, Integer id) {
        this.word = args;
        this.id = id;

    }


    public String getWord() {

        return this.word;
    }

    public void setWord(String word) {

        this.word = word;
    }

    public Integer getId() {

        return this.id;
    }

    public void setId(Integer id) {

        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ODTaskDuoble odtask = (ODTaskDuoble) o;
        return Objects.equals(word, odtask.word) && Objects.equals(id, odtask.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(word, id);
    }
}



END_OF_JAVA_CODE

# use Inline::Java;

my $alu = new ok::test::Pod_alu();
my $sum = new test::test::Pod_sum();
print($alu->add(9, 16) . "\n");      # prints 25
print($alu->subtract(9, 16) . "\n"); # prints -7

print($sum->add(5, 15) . "\n");       # prints 20
print($sum->subtract(19, 29) . "\n"); # prints -10
say $sum->outPrint;

my $gfl = new gfl::test::GFL();
$gfl->testGFL();
