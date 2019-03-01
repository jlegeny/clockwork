---
title: "Eventail 3.0 and beyond"
date: 2019-03-01T11:41:39+01:00
layout: post
categories: Eventail
tags:
---

I have released a few versions of Eventail since my last post.

# Version 3.0

The notable major update 3.0 has brought the _interactive mode_. When active, the widget will give each entry more space in the day view and populate each entry with buttons which can launch various actions.

![image-iphone-im]

[image-iphone-im]: /images/2019-03-01/iphone-tilted@2x.jpg

The actions can open the events or reminders in an app of the user's choice, start navigation to a specific event, join a conference call and more. The full list is described in the [documentation][eventail-doc-im].

This new mode is malleable and makes it easy for me to add integrations with other applications in the future.

[eventail-doc-im]: https://eventail.app/documentation.latest.html#settings-behaviour-interactive-mode

# Version 3.1

The 3.1 update for Eventail has brought support for, what I call, "universal URLs". What this feature does is that any event or reminder that has the URL property set, will have a button in the widget to open it.

First usage that pops to mind is adding URLs to events manually, and there are some great candidates for that. For example you can use the [iOS shortcuts URL scheme][ios-scus] to launch a shortcut.

[ios-scus]: https://support.apple.com/en-gb/guide/shortcuts/run-a-shortcut-from-a-url-apd624386f42/ios

Another handy feature of iOS is that it will add a callback URL here every time you create an event from a message, be it an e-mail or iMessage. Since the message itself can contain useful information (such as a door access code for your hotel or flight reservation number) the ability to show it immediately from the lock screen is very practical.

# Version 3.1.1

In version 3.1.1 I have added a possibility to define custom URLs for opening events and reminders. This way, I will not have to manually enter all possible URLs. A simple template will do. I will try to scour the Internet and add as many URLs for popular apps into the documentation.

# Sneak peek into the future

Next release will bring a possibility to display the reminders with due dates inside the Todo widget instead of the Calendar view. Possibly there will be some new integrations as well.