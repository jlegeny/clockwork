---
layout: post
title:  "A bookmarklet to make a stretched article readable"
date:   2013-07-09 11:21:00
categories: knacks
tags:
- Bookmarklet
- Readability
- Web
---

There are many tools like [Readability][1] or [Evernote Clearly][2] to make any arbitrary article readable and they are very good at their job.

Sometimes however you do not want to get rid of all of the formatting and sometimes they simply just do not work, e.g., on web forums.

One thing you can find all over the Internet is pages stretched from side to side, and they are all but readable on larger screens. Of course with responsive design you can just resize your browser but that is not what you want to do all of the time.

Here is a handy bookmarklet that will 'columnize' any webpage:

```js
javascript:d=document.getElementsByTagName('body')[0];d.style.width="11in";d.style.margin="0 auto";void(0);
```

Enjoy

 [1]: http://www.readability.com/
 [2]: http://evernote.com/clearly/