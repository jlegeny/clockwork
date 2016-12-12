---
layout: post
title:  "Redesigns for the worse"
date:   2013-04-14 23:03:55
categories: Rant
tags:
- Apple
- design
- iOS
---

With the iPhone 5S release approaching feature wish lists and redesigns of iOS7
are legion on the Interwebz. Undoubtedly many people find that iOS in its
current state lacks features, looks old and boring, and more generally "has to
catch up with the competition".

Usually the argument goes in the lines of "the home screen is just a list of
icons" or "Apple must put widgets on the screen" or even "iPhone should
centered around people, not apps". Many proposed changes poke around the lock
screen, many of them add a lot of eye candy, most of them are just wishful
thinking.

It seems that lot of designers want to be part of the apple experience, want to
show their skill by "improving" the user experience of an applauded product.
The problem is that they base their designs on opinions of a minority (albeit
very vocal) of geeks and tech enthusiasts. They criticize Apple's design
decisions without looking at the reason behind them.

Let us look at some examples and see what's wrong with them:

## Case: the iOS7 redesign video

A few days ago Federico Bianco has published a [video of his ideas of how iOS 7
should look like][1]. General reception, if we take comments on forums such as
Mac Rumors, was positive. But it these comments were several very good remarks.

### Lock screen

The first thing that comes in mind after seeing all of those lock screen
features is security. Judging from several security holes that have surfaced in
the past months it is apparent that the less features the lock screen has, the
better. In its current state it can display time, notifications (that you have
chosen to appear there), let you call emergency numbers and take a picture. For
any other action you need to type in your passcode. Now, of course not all
people use the passcode protection but most people do and it is a good practice
that should not be discouraged.

After the redesign one can reply to texts, call arbitrary numbers, switch off
wifi and my personal favorite: put the phone into airplane mode. What a joy
when some random bloke can cut your phone off as a prank whenever you leave
your phone out of sight for a minute. Apple has put a lot of effort so that
without passcode people can not access even your photos and this dude lets
everybody happily use your call minutes.

### Widgets

The widgets Mr. Bianco proposes are a nice touch, in theory the allow you to
peek at some of the information the application provides and in some cases take
some rudimentary action. In practice the implementation is quite poor.

One very important thing to consider when using the double tap/click is the
action that happens when the user is too slow. For example if we consider the
selection on iOS then if the double tap is too slow one would move the cursor
with the first tap and open the selection menu with the second. Once there one
can select the word with a single additional tap.

In the case of double tap opening widgets, a wrong gesture would open the app.
No big problem as you can get the information from inside the app as well as
from the widget, as long as it does not take too long to open which would be a
major frustration. Instead of earning half a second you would lose two.

The one thing I do not get with all these on-screen widgets is their utility.
Why would I throw out place for apps to put some random information instead?
What is the point of putting them on the main screen when in order to access it
you need to close your current app?

Apple does already have a perfect place for widgets, the only missing thing is
opening the API. You have guessed it: the notification center. The NC is the
best place to put all kinds of widgets for several reasons:

1.  It is already there
2.  It is accessible from everywhere
3.  People are already familiar with it
4.  Jailbreak community has already shown that it works

If Apple would open the API then a lot of people would be happy.

### Settings drawer

Another active corner = another hidden feature. There is clearly a huge demand
for quicker access to settings. However I would see this more either as a
widget (made by Apple, there is not much hope that apps will ever get access to
phone settings) or inside the app switcher alongside music controls.

### Mission control

Task switching was remade by a great ton of designers such as [here in this
video][2]. Some of them are already available for the jailbreak community, like
the much appraised [Auxo][3].

The common point of all of this switchers are snapshots or live previews of the
applications. In the case of Auxo they are completely useless as they are
hardly twice as big as the app icon. The icon itself is shrunk. It is beyond me
how somebody thinks this is a good idea. A snapshot preview consumes
considerably more memory than an icon and it is much harder to quickly
recognize.

As for live previews, they bring up the problem of real multitasking. Although
background running apps could, in theory, provide a live preview, for most of
them that would be impossible. Simply because the background process is not the
same and the renderer for the application does not run and should not run
because of performance issues.

### The shelf

This is the best idea in the video in my opinion. The major issue I have with
it is the fact that it sits on your dashboard as a folder. The news stand like
shelf can only show 3 files on the iPhone at the same time, which is really not
enough if you consider the quantity of the files that would end up there.

I really like the idea of system-wide file repository, as long as it is
organized by type and searchable and not in a folder-like structure.

## Case closed

Well, my rant is finished. It was largely based on comments and articles I read
previously such as the piece on [Unsolicited redesigns][4]. Of course
redesigning something is a boatload of fun, however it would be nice if people
first asked themselves "why" has the original author done it one way or another
before trying to improve on it.

 [1]: http://youtube.com/watch?v=JdW4qNeFkBk
 [2]: http://youtube.com/watch?v=iRt5qagkGBU
 [3]: http://youtube.com/watch?v=c4IA5AvqUYA
 [4]: http://ignorethecode.net/blog/2011/05/15/unsolicited_redesigns/
