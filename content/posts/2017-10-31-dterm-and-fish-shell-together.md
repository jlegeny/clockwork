---
layout: post
title: DTerm and Fish shell, together
date: 2017-10-31T15:10:51Z
categories: Knacks
tags:
 - Fish
 - macOS
---

Fish shell does not seem to like to live within the DTerm terminal emulator. Sadly, DTerm seems in a state of abandon.

What I do now is to force `bash` as the shell used by DTerm. I do this by launching:

```fish
env SHELL=/bin/bash open /Applications/DTerm.app
```
