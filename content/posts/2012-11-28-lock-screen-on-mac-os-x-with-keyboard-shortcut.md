---
layout: post
title:  "Lock screen on Mac OS X with keyboard shortcut [updated]"
date:   2012-11-28 16:56:37
categories: Knacks
tags:
- macOS
- Security
---

*Last update: 2017-11-18 for High Sierra*

Luckily we now have a real shortcut without hacks using **⌃⌘Q**

One of the issues that rises the most eyebrows while using Mac OS X is that
there is no native way of simply locking your screen with a keyboard shortcut.
Finally I have managed to compile all of the stuff on the Internet to come up
with a simple yet *real* solution to this problem If you can not be bothered by
reading the whole article here is the short version:

1.  Run **Keychain Access** go to **Preferences → General → Show keychain status in menubar**.
2.  Look at [this tutorial][1]. 
3.  Use the script from [freespace's github page][2] instead of my example. 

And now for the long version.

## Introduction

There are a lot of ways to work around this problem and many of them were
already published on a zillion of blogs. In practice four methods prevail:

1.  Setting the system to lock immediately upon launching the screensaver and
    then using the **ctrl+⇧+⏏** (control+shift+eject) shortcut.
2.  Enabling the Keychain Access menu item and then choosing **lock screen**
    from the menu (by mouse).
3.  Enabling the multiple user login and then switching user.
4.  Using a third party software, such as Quicksilver or Alfred.

Of course these methods have all some benefits and some drawbacks. When we look
at them we can easily spot that only the option two actually does what we want:
it locks the screen without closing the session, it is native and it *has* to
be invoked by the user. However it does not use the feedback, so fails to
satisfy the primary objective.

## The real solution

It is extremely simple to assign a keyboard shortcut to any item in the
application menu. Sadly, the task bar is not considered part of it and the
keyboard shortcuts will not reach it. Enter AppleScript and Automator, solution
to any problem there is! It took some digging but there actually **is** an
AppleScript which clicks on menu items. With that we can create a service that
will then be available thorough a global shortcut.

### Preliminary

In order for this to work you need to enable the Keychain Access menu item. Run
**Keychain Access** go to **Preferences → General → Show keychain status in
menubar**,

### Implementation

The path from a script to a service to a keyboard shortcut is already paved. I
have already covered how to [assign a global keyboard shortcut to a script][1]
so please refer to that.

### The script

The actual script to use is taken from [freespace's github page][2] and is
actually based on an example provided by Apple itself. For the sake of
consistency, here is the script:

```applescript
tell application "System Events"
    get properties
    get every process
    if UI elements enabled then
        tell process "SystemUIServer"
            repeat with i from 1 to number of menu bar items of menu bar 1
                if description of menu bar item i of menu bar 1 is "Keychain menu extra" then
                    tell menu bar item i of menu bar 1
                        click
                        if name of menu item 1 of front menu is "Lock Screen" then
                            click menu item "Lock Screen" of front menu
                            exit repeat
                        end if
                    end tell
                end if
            end repeat
        end tell
    else
        tell application "System Preferences"
            activate
            set current pane to pane "com.apple.preference.universalaccess"
            display dialog "UI element scripting is not enabled. Check \"Enable access for assistive devices\""
        end tell
    end if
end tell
```


And for the sake of clarity: I did not code this script.

 [1]: /2011/05/global-keyboard-actions-in-snow-leopard-without-third-party-software "Global keyboard actions in Snow Leaopard without third party software"
 [2]: https://gist.github.com/1322095 "https://gist.github.com/1322095"
