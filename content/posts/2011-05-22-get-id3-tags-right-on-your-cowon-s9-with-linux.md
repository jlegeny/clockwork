---
layout: post
title:  "Get ID3 tags right on your Cowon S9 with Linux"
date:   2011-05-22 13:49:31
categories: Knacks
tags:
- Linux
---

Those ID3 tags on Cowon can be pesky. Sometimes you do not see the embedded
images, sometimes you see things like [11] instead of genres and if you are
really unlucky you will not see any tags at all. So, as a quick hint on how to
get all of this right:

1.  Use [EasyTAG][1] (can be downloaded using your package manager in most
    distributions)
2.  In Settings → Preferences go to the ID3Tag settings and do the following
    *   Check Automatically convert old ID3v2 tag versions
    *   Check Write ID3v2 tag → **Version 2.3**
    *   Uncheck Write ID3v1.x tag
3.  Edit tags of your files, be sure to re-save all files which appear in red
in EasyTAG as they have probably different versions of ID3 tags

![easytag-settings]

If you want to use images from the tags instead of the per-folder cover.jpg
files you can use EasyTAG to include them in the tags as well. Bear in mind
though that only **jpeg** files will be taken into account and only in mp3
files (no love for ogg users). Also for best effects use images of 272  x 272
pixels large.

 [1]: http://easytag.sourceforge.net/ "EeasyTAG for Linux"
 [easytag-settings]: /images/EasyTAG-Cowon-settings.png "EasyTAG Cowon settings"
