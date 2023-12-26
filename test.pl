#!/usr/bin/perl

use Cwd qw( abs_path );
use File::Basename qw( dirname );
use lib dirname(abs_path($0));

use Hugo;

system("${\(hugo_bin())} server --buildDrafts --buildFuture --disableFastRender --bind 0.0.0.0");

