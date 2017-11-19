---
layout: post
title:  "Creating a document management program that actually works - Part 1"
date:   2012-04-21 17:42:20
categories: Rant
tags:
- management
- productivity
---

I have tried several document management programs, applications, systems -
whatever you want to call them. Finally I have decided to abandon all of them
for a bunch of folders, which is not exactly ideal. Thing is, I really like
working with libraries rather than the filesystem itself. It is much more
convenient, but also brings a lot of crap to the house. You can not really move
a library, if it is in a binary form you will have hard way synchronizing it
over several computers (YES! I want my files in Dropbox).

I have decided to make a document management system on my own. I have currently
no idea how will it look in the end, because I do not know yet about what I
want it to do. Nevertheless I will rant here for a while and maybe some day I
will find out on how to do this thing right.

## What should a good document management system do?

There are many things a document management system should do, but there are
even more things it should not. There lies the problem with most of the
applications.

As an example of a *good* library manager I would cite Amarok, Quodlibet and
iTunes (the latter only for the music collection).

- While using the application you do not have to worry about where the files
are, what is their format and stuff like that. When you are not using the
application you can, however, navigate in the files easily.
- The metadata is actually saved in the documents (id3 tags, for example) so
even if you lose your library (the database), it is very easy to reconstruct.
(quodlibet does not use any database whatsoever)

As examples of *bad* document managers, let us have a look at iPhoto or Evernote.

- The files are saved “somewhere”, there is no way of poking into the file
structure of the application database without breaking something.
- They provide a lot of features, which is good, but there is no way of adding
some. If you use an external application to edit a photo in iPhoto library you
are losing most of the features : the new version is not linked to the
original, no way to revert back, no nothing.
- If you lose your library then reconstructing it all over again from the
originals is a huge pain in the ass.
- Some things you would be able to do with vanilla files are no longer an
option.

Basically what I am trying to say is that while a good management system should
not require you to use the filesystem in any way, it should use it in order to
get things done. There is no need to reinvent the wheel here.
