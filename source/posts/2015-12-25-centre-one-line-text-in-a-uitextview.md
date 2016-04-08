---
layout: post
title: Centre a one line text in a UITextView
date: 2015-12-25 07:59:02 UTC
category: Knack
tags:
 - UIKit
 - iOS
---

I had a problem. First I have set up an UITextView with these parameters:

    view.backgroundColor = UIColor.blueColor()
    view.text = "An example text"
    view.textColor = UIColor.whiteColor()
    view.textContainerInset.top = 0
    view.textContainerInset.bottom = 0

I wanted to be able to centre the text in the view vertically. This should be easy, one just needs to position the top of the text according to the formula: `top = (container.height - content.height) / 2`. However, when you look at the actual look of the UITextView you will see this:

    view.font = UIFont.boldSystemFontOfSize(100.0)

![][def-system]

    view.font = UIFont(name: "DINCondensed-Bold", size: 100.0)

![][def-din]

Ouch, there is a semi-randomly placed offset at the top of the text. Turns out the point size of a font is not always the one you have demanded. However it is possible to get the actual height. An `UIFont` class provides a bunch of useful metrics:

    view.font = UIFont.boldSystemFontOfSize(100.0)
    view.font.capHeight // 70.5
    view.font.pointSize // 100.0
    view.font.ascender // 95.2
    view.font.lineHeight // 119.3

    view.font = UIFont(name: "DINCondensed-Bold", size: 100.0)
    view.font.capHeight // 71.2
    view.font.pointSize // 100.0
    view.font.ascender // 71.2
    view.font.lineHeight // 100.0

On a graph this would look like this:

![][metrics]

Finally, the method you can now use is:

    extension UITextView {
      func centerTextVertically() {
        guard let ascender = view.font?.ascender else {
          return
        }
        guard let capHeight = view.font?.capHeight else {
          return
        }
        view.textContainerInset.top = (view.bounds.height - ascender - (ascender - capHeight)) / CGFloat(2.0)
      }
    }

Note that this will only for one liners and only if you know the height of the `UITextView` (i.e.: the height was given to it on creation)

 [def-system]: /images/uitextview-centring/uitextview-default-system.png
 [def-din]: /images/uitextview-centring/uitextview-default-din.png
 [metrics]: /images/uitextview-centring/uitextview-metrics.png
