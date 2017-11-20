#!/usr/bin/perl

die "Environment not set" unless $ENV{CLOCKWORKSSH};

system("hugo");

system("rsync -avz -e ssh public/ $ENV{CLOCKWORKSSH}:clockwork/") unless $?;

