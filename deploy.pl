#!/usr/bin/perl

use Cwd qw( abs_path );
use File::Basename qw( dirname );
use lib dirname(abs_path($0));

use Hugo;
    
die "Environment not set" unless $ENV{CLOCKWORKSSH};

system(hugo_bin());

system("rsync -avz -e ssh public/ $ENV{CLOCKWORKSSH}:clockwork/") unless $?;

