---
title: "Parallels 12 and Windows 7 Slow Cursor"
date: 2017-11-22T11:41:09+01:00
layout: post
categories: Knacks
tags:
 - Computer Problems
---

After updating my macOS, Parallels 12 has broken loading a VM from the
Bootcamp partition. This has forced me to use my Windows 7 virtual machine
and I have discovered a weird problem:

The mouse cursor inside the virtual machine is really slow if an
application is loading something or doing some activity.

At first I thought this was because the machine was hogged, but the
problem is actually simpler than that: _Windows 7, in Parallels 12, is
really **slow** when rendering an animated cursor_. I have changed my
cursor theme to an old non-aero one and everything is fine now.

