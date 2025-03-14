---
layout: post
title:  "Make Notes.app more beautiful"
date:   2013-11-11 15:59:51
categories: Hacks
tags:
- macOS
---


A bit of googling shows that the old version of the Notes.app will not work in Mavericks. But luckily one quickly finds out that the Resources folder is quite resourceful.

Namely there are two files that are interesting:

In `/Applications/Notes.app/Contents/Resources` there is a file named `paper.tiff` which looks like this:

Yup, this is the ugly texture under the text. Small change to it and we have something looking like a post-it already. Now, this method is not new and plenty has been written about it.

The other change is to change the default fonts, once again in `/Applications/Notes.app/Contents/Resources/en.lproj` there is a file called DefaultFonts.plist and it is quite straightforward. I am a huge fan of TektonPro for notes so I put in

```xml
<dict>
<key>FontName</key>
<string>TektonPro-Bold</string>
<key>Size</key>
<integer>14</integer>
</dict>
```

And 'lo my new Notes.app look:

![Updated look of Notes.app][1]

I've made a quick mod to patch the files. You can grab it here:

[Mod for Notes.app v1][2]

 [1]: /images/Notes.app.png
 [2]: /files/downloads/Notes.app-Mod-v1.zip

