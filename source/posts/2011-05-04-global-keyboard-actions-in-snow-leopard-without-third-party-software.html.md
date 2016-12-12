---
layout: post
title:  "Global keyboard actions in Snow Leopard without third-party software"
date:   2011-05-04 08:00:15
categories: Knacks
tags:
- OS X
- Snow Leopard
---

When I first got to use Mac OS X I have wondered whether it is possible to do
stuff which I was used to do (more or less) easily on Linux. Among others there
is the possibility to assign keyboard shortcuts to arbitrary actions (and
especially shell scripts). I found several tutorials on how to do this, but
they often include third party software like Quicksilver. Since I want to keep
my system as vanilla as possible I was searching for a way to do it otherwise,
and found it.

## Introducing Services

Snow Leopard has this great thing called Services, which is a very simple to
use way of creating very powerful actions in no time. Now, usually these are
bound to a specific application or context, but they can be global. Since it is
much easier to explain something on an example, let us use a simple example.
Following this article on how to pause iTunes for a short period of time.

### Step 1

1.  Open up the **Automator**.
2.  Create a New Service.
3.  In the 'service receives selected' drop-down box select **no input** in
    **any application**.
4.  In the left sidebar find **Run AppleScript** and drag it into the workflow
5.  Paste the code below on the place where it says *(* Your script goes here
    *)*
6.  Save the service as "Pause iTunes for 5 minutes"

The script in question follows:

    tell application "iTunes"
        pause
        delay 300
        play
    end tell

In the end the whole Automator window should look like this.

![automator-service-example]

[automator-service-example]: /images/global-mac-shortcuts/Automator-service-example.png "Automator service example"

If you go to the current application's menu now you should see your service in
the Services sub-menu.

### Step 2

Now the only thing that remains is to add a keyboard shortcut for this service.
Open up System Preferences → Keyboard → Keyboard Shortcuts. In the left panel
click on Services and then click on the + button under the right panel. In the
following dialog choose:

*   Application : **All Applications**
*   Menu Title : **Pause iTunes for 5 minutes**
*   Keyboard Shortcut : **F10**

Following shortcut illustrates the result. Note that it is vital that the Menu
Title chosen is **exactly the same** as the name under which you have saved the
service.

[Update] New services will be added to the list automatically. The only
remaining thing is to add a shortcut key. This might be a feature of Lion or
Mountain Lion as I do not recall it while using 10.6.

![shortcut-asignment]

[shortcut-asignment]: /images/global-mac-shortcuts/Automator-service-example.png "Snow Leopard keyboard shortcut assignment"

All done, you can now enjoy launching your script anywhere, anytime by pressing
F10.
