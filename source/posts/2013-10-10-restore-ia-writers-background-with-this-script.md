---
layout: post
title:  "Restore iA Writer&#039;s background with this script [Update]"
date:   2013-10-10 00:42:44
categories: Enhancements
tags:
- background
- iA Writer
---
This is a very quick and dirty utility to restore iA Writer’s background to the pre–1.3.1 state. What it does is that it replaces these three images inside the iA Writer folder: *backgroundPattern*, *tr-up-pattern* and *td-down-pattern*.

The original solution was posted in [this thread on the support forum][1].

[Background fix for iA Writer 1.5][2]{: .btn}

To use this script simply unzip the file wherever you like. Once it is done run the script like this in the terminal (it will be ran as root, you will have to enter your password)

    sudo sh bgfix.sh


Updated to work with iA Writer 1.5 on 2013-10-10

Enjoy

<small>This post was originally posted on 2012-10-24</small>

 [1]: http://support.iawriter.com/help/discussions/mac-suggestions/389-ia-writer-surface-design
 [2]: /files/downloads/iAWriter-BGFix-1.5.zip