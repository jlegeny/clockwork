#!/usr/bin/perl

use Hugo;

system("${\(hugo_bin())} server --buildDrafts --buildFuture --disableFastRender");

