---
title: "Why Does Eventail Have So Many Settings?"
date: 2018-04-20T20:00:00+02:00
layout: post
categories: Eventail
tags:
  - Eventail
  - Design
---

In general, I do dislike applications which have many settings. It might be a little bit surprising that [Eventail][eventail] falls into this category. If you look at the whole un-cropped UI it might be a perfect fit for the sword-like iPhone 20.

In design, I try to abide to this rule:

> "If you want to add an option, you need to decide on the default value. Once you have chosen the default, keep it and remove the option." 

With Eventail, I have broken this rule in two ways: On top of having many options, Eventail's defaults are not even what I would recommend people to use.[^defaults]

[^defaults]: I have opted for the switch options to be all in the positive tone: "display this," "enable that". For the sake of consistency and discoverability, they are all turned on by default. I would recommend to hide the empty days though.

## The perfect app

![eventail-settings]

[eventail-settings]: /images/2018-04-20/eventail-settings@3x.png#floatright

The ultimate goal of Eventail is to be a perfect calendar widget for the masses. As I have argued in my [article about e-mail clients][cwk-email]: everybody's definition of perfect is different. As such, I have defined two ground rules about the widget which will stay unbroken.

- The app uses iOS calendar API, I will not be making any custom clients to manage CalDav or Exchange servers.
- The app stays a simple and nice to look at widget. There are already a lot of great calendaring apps.

The first rule dictates limits on the features I can implement. For example there is no way I could handle Exchange categories or Google custom event colors in the current iOS (11.3).

The second rule might look at odds with many settings, but it is the widget itself that must stay simple. My stats show that most people who download Eventail launch the application once or twice. This is either because the app is crap, or because they set it up the first time they launch it and stash it in a dump folder. I choose to believe in the second case since this is how I intended people to use the app.

The complexity of settings dissipates after you have customized the widget to suit your needs. Tap and a detailed view opens, tap again and you are back. Two states is all there is. This is why the widget has (unlike other apps) a prominent preview of how will it look on top.

## Behind the scenes—options that got axed

Although this means that Eventail will grow in complexity, it will not have _all of them, the features_.

In the 2.2 version, I have added a thin left border on the events in the default theme. Initially, this was a separate theme because I did not want to get e-mails from people unhappy with the change. In the end I have decided to risk the hit. The new theme is more iOS-like and it makes the choice of the theme simple–just decide whether titles or calendars are more important.

New icons for events were initially optional, there was a fallback to spheres for everything. Again, other applications use spheres all the time, but I wanted the invitations to be distinct. There may be more icons coming for other things. For example would it not be great to see a group of two people when there are just two people in the event?

[eventail]: https://itunes.apple.com/us/app/eventail/id959674103?ls=1&mt=8&at=1010lIXq
[cwk-email]: https://yozy.net/2018/03/why-there-is-no-perfect-email-application/
