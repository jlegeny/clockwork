---
layout: post
title:  "Best editor for Chinese text on Mac"
date:   2012-06-24 16:15:27
categories: Knacks
tags:
- chinese
- OS X
- text editor
- writing
---

I have spent some time (like an hour or so) looking for a good editor for
Chinese script on Mac OS X. To my surprise most of what I have tried sucked in
one or more ways.

## Competitors

Of course, I have started with the editor I use to edit plaintext daily -
**iA Writer**. For once, I have said to myself, the humongous font
this editor uses would be very useful. Sadly, iA Writer uses the default OS X
font for chinese. This derivate of Heiti is quite broken and many glyphs are
wrong (this was pointed out to me by a native speaker). Also, line height of
lines with chinese characters is weird, and it changes depending of the
presence of non-chinese characters in it (including blank space). I have
reported the issue to the authors and it was acknowledged so there might be a
different font used in future versions… we will see.

So my first choice did not work out. No worries, there are plenty other editors
to check. My second choice was [**MacVim**][ln-macvim], which is the best
invention since sliced bread. The experience was very poor. The insert mode
works well, as expected, however the normal mode hates IMKQIM input method. It
would seem that Vim was not meant to be used with other than standard input
methods, which is understandable.

[ln-macvim]: http://code.google.com/p/macvim/ "MacVim"

Moving on. Since alternative software did not work out I tried the native
solutions. **TextEdit** is usually a very good text editor, if you
do not need any features. When writing immediately (in plain text mode), you
will run into the same problem as with iA Writer : horrible font. You can
change the font for plain text mode, of course, but you have to choose the
right one. STSong is a good choice, with other fonts you might run into
problems with line heights (as some fonts miss some glyphs).
**Fraise** suffers from similar problems.

I have also tried **Pages**, it works really well, with the right fonts. Line
heights are always OK. But it is not a plain text editor, and it has all the
downsides of a text processor with hundreds of options.

## Conclusion

Finally, I ended up with yet another editor. I have dug up the rusty
[**FocusWriter**][ln-focuswriter] which I have abandoned previously to
iA Writer. The possibility to switch themes makes it a good choice for
different scripts. My choice was the 华文细黑 font.  Best of all FocusWriter is
available on all platforms, so I just use that on Linux as well.

[ln-focuswriter]: http://gottcode.org/focuswriter/ "FocusWriter"

---

*Edit 2015-10-18*

iA Writer no longer has the aforementioned problems, at least in OSX 10.11
