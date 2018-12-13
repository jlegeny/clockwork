---
title: "Web applications cannot replace native ones"
date: 2018-12-10T11:23:58+01:00
layout: post
categories: Rant
tags:
---

<aside class="note">Note: This rant is about programs running in browser windows, I will address Electron in some other post.</aside>

Increasing amount of tools are written for web, many presenting themselves as replacement for standard desktop applications.

For simple stuff this is fine, few people would like to install an application for every shop or transport provider.

Complex programs running in tabs hit an insurmountable hurdle: "they cannot implement correct keyboard shortcuts". And it is a problem that nobody has figured out yet, it is a fundamental issue that will never be fixed.

Some examples that come to mind:

- How would you open a tab in your web app? <kbd>⌘T</kbd> opens a new browser tab. What about a new window<kbd>⌘N</kbd>?
- How do you undo? In Safari <kbd>⌘Z</kbd> undoes closing of a tab.
- If your application provides a save option, what would you use? <kbd>⌘S</kbd> will try to save a useless HTML document.

Another problem is selection. <kbd>⌘A</kbd> selects everything, this is _never_ what you want to do in an application, but it can be something you want to do on a webpage. This means you need to break one behavior or the other.

