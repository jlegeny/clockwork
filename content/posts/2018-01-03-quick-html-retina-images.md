---
title: "Pure CSS solution to retina images with a single file"
date: 2018-01-03T10:20:50+01:00
layout: post
categories: Hacks
tags:
  - HTML
  - CSS
  - Programming
---

Problem: You have an image and want it to display well in browsers on a high DPI display. There are many ways to do this, some of them [more complicated][1] than [others][2].

[1]: http://mir.aculo.us/2012/06/26/flowchart-how-to-retinafy-your-website/
[2]: http://brianflove.com/2014/08/07/retina-display-images/

My requirements were pretty simple:

- I want to be able to publish "retina" images with default markdown syntax
- I prefer images to be blurry on non-high DPI screens, they are blurry anyway so what's the harm.
- I do not care about wasted bandwidth by sending retina assets to clients with standard definition screens. Not having ads or huge javascript on this site makes up for this.
- I do not want to use any javascript or server side hacks

So what's the solution?

1. Name @2x assets with `@2x` in their filename, for example image@2x.png
2. Add this small snippet into my CSS file (thanks, Internet Explorer!)

```css
img[src*='@2x'] {
  zoom:50%;
}
```

For an example usage look at my [article about Qt Creator](https://yozy.net/2018/01/qt-creator-hidden-gems/)


