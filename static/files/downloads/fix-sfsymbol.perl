#!/usr/bin/perl

my $file = $ARGV[0];

open FILE, $file or die "Failed to open file: $!";
$/ = undef;
my $xml = <FILE>;
close FILE;

my @weight = (
  "Ultralight", "Thin", "Light", "Regular", "Medium",
  "Semibold", "Bold", "Heavy", "Black",
);

my @size = ("S", "M", "L");

for my $w (@weight) {
  for my $s (@size) {
    $xml =~ s/<g (transform=[^>]+?)>\s+<g (id="$w-$s")>(.*?)<\/g>/<g \2 \1> \3/s;
  }
}

print($xml, "\n");

