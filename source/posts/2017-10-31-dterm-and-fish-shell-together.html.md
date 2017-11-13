---
layout: post
title: DTerm and Fish shell, together
date: 2017-10-31 15:10:51 UTC
category: knack
tags:
 - Fish
 - DTerm
 - macOS
---

Fish shell does not seem to like to live within the DTerm terminal emulator. Sadly, DTerm seems in a state of abandon.

What I do now is to force `bash` as the shell used by DTerm. I do this by launching:

    env SHELL=/bin/bash open /Applications/DTerm.app
