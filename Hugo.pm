#!/usr/bin/perl

package Hugo;

use base 'Exporter';

our @EXPORT = qw(hugo_bin);

sub hugo_bin {
  my $system = `uname -s -m`;
  chomp $system;

  my $program;
  if ($system eq "Darwin x86_64") {
    $program = "./bin/hugo_macos";
  } elsif ($system eq "Linux x86_64") {
    # $program = "./bin/hugo_linux_x64";
    $program = "hugo";
  } elsif ($system eq "Linux armv7l") {
    $program = "./bin/hugo_linux_arm64";
  } else {
    die("Unknown system detected");
  }
  return $program;
}
