#!/usr/bin/perl

die "Environment not set" unless $ENV{CLOCKWORKSSH};

print `middleman build`;
print `rsync -avz -e ssh build/ $ENV{CLOCKWORKSSH}:clockwork/`;

	
