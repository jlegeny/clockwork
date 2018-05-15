---
title: "What happens when you delete ~/.Trash folder on macOS"
date: 2018-05-15T13:00:00+02:00
layout: post
categories: Hacks
tags:
 - macOS
 - UX
---

I have done some stupid stuff and managed to delete the `~/.Trash` folder on my Mac. The result was surprising:

<video width="720" height="600" controls>
  <source src="/videos/finder-delete-trash.mp4" type="video/mp4">
	Your browser does not support the video tag.
</video>

To fix this you can type this in the shell:

```shell
mkdir ~/.Trash
```

This is clearly bad user experience. Somebody not knowing how to fix this will just assume that the trash stopped working. Even worse, they might miss the message and just click on Delete.

What should macOS do in this case, is to silently restore the trash folder and keep on humming.