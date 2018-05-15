---
layout: post
title:  "Vintage effect Script-Fu for GIMP"
date:   2011-04-27 08:00:02
categories: Enhancements
tags:
- GIMP
- Scripting
- Scheme
---

Any self-respected hipster photographer must provide his share of vintage
photos with helvetica captions. In order to make life easier for people using
the Greatest Image Manipulation Program™ I have made a script which does the
hard part. The provided script is based on [this tutorial][gimpology-tutorial].
Download the script and put it into your `${HOME}/.gimp/scripts` folder (or its
equivalent on your system).

[Vintage Color script for GIMP][dl-script]


## Some demos

![ducks]
![ducks-vintage]

## Changelog

version 1.1

*   put the whole script into an undo group
*   replaced deprecated functions by newer ones - operating on items

version 1.0

*   initial release

 [gimpology-tutorial]: http://gimpology.com/submission/view/authentic_vintage_effect "Authentic Vintage Effect GIMP"
 [dl-script]: /files/downloads/vintage_color_v1.1.scm "Vintage Color script for GIMP"
 [ducks]: /images/gimp-vintage/ducks.jpg "Photo of Ducks"
 [ducks-vintage]: /images/gimp-vintage/ducks-vintage.jpg "Altered photo of Ducks"
