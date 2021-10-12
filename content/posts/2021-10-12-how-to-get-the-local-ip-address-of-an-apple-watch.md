---
title: "How to Get the Local IP Address of an Apple Watch"
date: 2021-10-12T12:03:48+02:00
layout: post
categories: Hacks
tags:
  - Apple
---

The Apple Watch does not display its local IP address in the settings for some
reason. Here is one way to get it, if you have a second Mac on the network.

1. Open terminal on the mac, run `python -m SimpleHTTPServer`.
2. Get your Mac's local IP address (option+click on the network icon in the
   toolbar).
3. Send yourself an iMessage with text `http://YOUR_MACS_IP:8000`.
4. Turn WiFi off on your iPhone. This is important because the Apple Watch
   can use your phone's WiFi.
5. Open Messages on your watch, find the message, tap on the link.

In the terminal on your Mac you will see something like
`192.168.0.21 - - [12/Oct/2021 12:00:00] "GET / HTTP/1.1" 200 -`.

And there you have your Watch's IP address.

