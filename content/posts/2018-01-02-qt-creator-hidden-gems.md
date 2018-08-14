---
title: "Qt Creator Hidden Gems"
date: 2018-01-02T11:57:28+01:00
layout: post
categories: Knacks
tags:
  - Qt Creator
---

When it comes to C++ IDEs I always reach for Qt Creator. I love its streamlined user interface which nevertheless exposes all screws and knobs if necessary.

But mostly I like how it manages to surprise me with every update.

Most recently I have updated to version 4.5.1 (from the 4.5 RC) and as I am hacking on the keyboard I see this:

![QtCreator detects output parameters](/images/2018-01-02/qt-creator-output-param@2x.png)

Finally a work around the terrible decision to not explicitly mark function parameters used as a reference in C++.

What's more, Qt Creator does support "relative" text style for this highlight. One `saturation +0.30` later I have:

![QtCreator can change text style relatively](/images/2018-01-02/qt-creator-output-param-hilight@2x.png)

Can't wait for what the 4.6 will bring!
