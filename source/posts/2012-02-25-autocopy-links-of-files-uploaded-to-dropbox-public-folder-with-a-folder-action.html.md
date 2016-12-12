---
layout: post
title:  "Autocopy links of files uploaded to Dropbox public folder with a folder action"
date:   2012-02-25 23:54:55
categories: Knacks
tags:
- Dropbox
- OS X
---

This tutorial is largely based on [this post on the Dropbox
forums][dropbox-forums-post], all credit on the script goes to the original
author Christian G. My contribution is that this script also invokes a Growl
message (thus, you will need Growl installed) also, the # character is replaced
by %23 (because Dropbox does not like it much) Here goes the script :

[dropbox-forums-post]: http://forums.dropbox.com/topic.php?id=4659

    on adding folder items to this_folder after receiving added_items
        try
            set the item_count to the number of items in the added_items
            if the item_count is equal to 1 then
                set theFile to item 1 of added_items
                set theRawFilename to ("" &amp; theFile)
    
                set tid to AppleScript's text item delimiters
                set AppleScript's text item delimiters to ":"
                set theFileName to (text item 6 of theRawFilename) as text
                set AppleScript's text item delimiters to tid
    
                set theWebSafeFileName to switchText from theFileName to "%20" instead of " "
                set theWebSafeFileName to switchText from theWebSafeFileName to "%23" instead of "#"
    
                set theURL to "http://dl.dropbox.com/u/YOUR_DROPBOX_ID/" &amp; theWebSafeFileName
                set the clipboard to theURL as text
    
                tell application "GrowlHelperApp"
    
                    set the allNotificationsList to ¬
                        {"Public URL"}
    
                    set the enabledNotificationsList to allNotificationsList
    
                    register as application ¬
                        "CopyDropboxURL" all notifications allNotificationsList ¬
                        default notifications enabledNotificationsList ¬
                        icon of application "Dropbox"
    
                    notify with name ¬
                        "Public URL" title ¬
                        "Dropbox Public Folder Updated" description ¬
                        (theURL &amp; " copied to clipboard.") application name "CopyDropboxURL"
    
                end tell
            end if
        end try
    end adding folder items to
    
    to switchText from t to r instead of s
        set d to text item delimiters
        set text item delimiters to s
        set t to t's text items
        set text item delimiters to r
        tell t to set t to item 1 &amp; ({""} &amp; rest)
        set text item delimiters to d
        t
    end switchText
    
## How to use this

First of allyou have to know your Dropbox user ID and change the
YOUR\_DROPBOX\_ID to it. This is the number that appears after /u/ in your
public Dropbox links. Now open the apple script editor and save this script
into

`Macintosh HD/Library/Scripts/Folder Action Scripts` as CopyDropboxURL.scpt.
Next navigate to your Dropbox public folder in finder, right click (or ⌘-click)
it. Choose Services→Folder Actions Setup... from the menu. In the menu that
opens choose the CopyDropboxURL.scpt.

