---
layout: post
title:  "Quick access to the last public url of a file in Dropbox"
date:   2011-05-08 08:00:14
categories: Knacks
tags:
- Shell
- Dropbox
- Linux
---

I got bored to search for the url after uploading a file to the Dropbox's
public folder. So I have hacked a quick shell script that takes the public url
of the latest file you uploaded to your public Dropbox folder and copies it to
the clipboard. I thought I could share:

```bash
#!/bin/sh
DROPBOX="$HOME/Dropbox" dropbox puburl "$DROPBOX/Public/\`ls -1 -t $DROPBOX/Public | head -n 1\`" | xclip
```

Now, on OS X I have a folder action which does the same thing automatically
when a new file is uploaded. I will have to tinker with inotify and get it to
work on Linux as well.
