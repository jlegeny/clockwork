---
layout: post
title:  "Enable system volume control for a generic USB device in Snow Leopard"
date:   2011-06-06 08:00:56
categories: Knacks
tags:
- macOS
- Computer Problems
---

This post is mainly targeted at people who have used an X-Fi USB audio card
with their PCs on Windows or Linux. Many of us got a bad surprise when we
plugged it into our shiny new Macs and we couldn't even control the volume of
the device through the system.

This particular problem is due to lack of dedicated drivers made by Creative.
It seems that they only make OS X drivers for cards specially targeted at Macs.

Luckily there is a way to work around this limitation using a piece of software called [Soundflower][soundflower]. The procedure is very simple, just follow the four steps here:

[soundflower]: http://cycling74.com/products/soundflower/ "Soundflower homepage"


- Download and install SoundFlower (this might require a restart)
- Set **Soundflower (2ch)** as your audio output device (hint: you can option (⌥)-click your volume control icon in the menu)
- Launch Soundflowerbed (it was installed along with Soundflower)
- In the 2 channel device output options select your USB card.

And it is done, you can happily use your volume control buttons once again.

![system-output]
![soundflower-output]

[system-output]: /images/soundflower-volume/soundflower_system_output_settings.png "Set system output to Soundflower (2ch)"
[soundflower-output]: /images/soundflower-volume/soundflower_driver_settings.png "Set Soundflower output to your USB card"

