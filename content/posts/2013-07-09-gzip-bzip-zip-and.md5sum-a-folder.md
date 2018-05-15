---
layout: post
title:  "gzip, bzip, zip and md5sum a folder"
date:   2013-07-09 19:00:39
categories: Knacks
tags:
---

During the OpenViBE releases I found myself to repeat this procedure ad
nauseum. So I made a little script that does the thing automatically. I will
just leave it here for future reference:

```perl
#!/usr/bin/perl

$folder = $ARGV[0];

print `tar czf $folder.tar.gz $folder\n`;
print `tar cjf $folder.tar.bz2 $folder\n`;
print `zip -9 -r $folder.zip $folder\n`;

print `md5sum $folder.tar.gz $folder.tar.bz2 $folder.zip > $folder.md5\n`;
```
  

Happy hacking
