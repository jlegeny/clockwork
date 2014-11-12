---
layout: post
title:  "Fix the home and end keys in Firefox with Keyconfig and Vimperator"
date:   2012-04-25 11:12:58
categories: Knacks
tags:
- Firefox
- keyboard
- Mac
- OS X
---

Somme funny man thought that it would be good to screw up the behavior of home
and end keys in firefox on Mac. Nobody knows why and everybody is complaining.
Also, the same genius have made the *⌘→* and *⌘←*
commands navigate in history instead of doing what they do in every other
application which is "move to the end or beginning of the line".

Oh well.. Luckily there IS a solution for this. The extension keyconfig will
fix half of the problem. [Get the keyconfing extension here][fx-extension] and
disable the incriminating keys. Many thanks to the author. Now you have working
command keys. As for the home and end key, I fixed my problem in vimperator,
since it is an extension I use on all of my firefoxes. Basically the idea is to
remap home and end (along with +shift variants)) so they fire off the
command+arrow commands. Here is the code, enjoy :

    imap <Home> <M-Left>
    imap <End> <M-Right>
    imap <S-End> <M-S-Right>
    imap <S-Home> <M-S-Left>

Either run it in the vimperator command line and do a :mkvimperatorrc! or put
it directly into your configuration file.

[fx-extension]: http://forums.mozillazine.org/viewtopic.php?t=72994 "Keyconfig Firefox Extension"

