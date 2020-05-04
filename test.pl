#!/usr/bin/perl

my $system = `uname -s -m`;
chomp $system;

my $program;
if ($system eq "Darwin x86_64") {
  $program = "./bin/hugo_macos";
} elsif ($system eq "Linux x86_64") {
  $program = "./bin/hugo_linux_x64";
} elsif ($system eq "Linux armv7l") {
  $program = "./bin/hugo_linux_arm64";
} else {
  die("Unknown system detected");
}
    
system("$program server --buildDrafts --buildFuture --disableFastRender");

