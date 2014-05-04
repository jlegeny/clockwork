#!/usr/bin/perl

use LWP::Simple qw($ua get);
#$ua->proxy('http','http://proxy:port');


use Irssi;
use Irssi::Irc;
use strict;
use warnings;
use vars qw($VERSION %IRSSI);
$VERSION="0.0.2";
%IRSSI = (
        authors => 'Jozef Legény',
        contact => 'jozef.legeny@gmail.com',
        name    => 'lastfm',
        description     => 'Writes the last played song on last.fm',
        license => 'GPL v2',
        url     => 'http://clockwork.fr/blog/irssi-lastfm',
);

sub cmd_lastfm {
  my ($data, $server, $witem) = @_;
  if (!$server || !$server->{connected}) {
    Irssi::print("Not connected to server");
    return;
  }
  
  my $song = get "http://ws.audioscrobbler.com/1.0/user/$data/recenttracks.txt";

  if ($data && $song) {
  	my @song = split /\n/,$song;
		$_ = $song[0];

		s/\n//g;
		/(\d+),(.*)–(.*)/;
		
		my $artist = $2;
		my $track = $3;
		
		my $text =  "$data last played >> $artist -- $track";
     $witem->command("/SAY $text");
  }
}


Irssi::command_bind('lastfm', 'cmd_lastfm');