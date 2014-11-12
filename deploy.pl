#!/usr/bin/perl

die "Environment not set" unless $ENV{CLOCKWORKSSH};

system("middleman build");

system("rsync -avz -e ssh build/ $ENV{CLOCKWORKSSH}:clockwork/") unless $?;

