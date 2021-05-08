#!/usr/bin/perl

use Cwd qw( abs_path );
use File::Basename qw( dirname );
use lib dirname(abs_path($0));

use POSIX qw(strftime);

use Hugo;

my $post_title = $ARGV[0];
my $date = strftime "%F", localtime;

system("${\(hugo_bin())} new 'posts/$date-$post_title.md'");
