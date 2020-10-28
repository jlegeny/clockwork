#!/usr/bin/perl

use Cwd;
use lib cwd;

use Hugo;
    
die "Environment not set" unless $ENV{CLOCKWORKSSH};

system(hugo_bin());

system("rsync -avz -e ssh public/ $ENV{CLOCKWORKSSH}:clockwork/") unless $?;

