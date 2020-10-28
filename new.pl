#!/usr/bin/perl

use POSIX qw(strftime);

use Hugo;

my $post_title = $ARGV[0];
my $date = strftime "%F", localtime;

system("${\(hugo_bin())} new 'posts/$date-$post_title.md'");
