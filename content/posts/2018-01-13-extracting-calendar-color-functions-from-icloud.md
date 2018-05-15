---
title: "How I discovered how iOS calendar app chooses colors by digging into the icloud.com JavaScript code"
date: 2018-01-13T19:50:00+01:00
layout: post
categories: Eventail
tags:
  - iOS
  - Eventail
  - JavaScript
  - Programming
---

While making an iOS calendar app, I needed to find out how Apple calculates background and text colors when displaying events in the Calendar app. I wanted to use the same algorithm for my display, in order to integrate well with the OS.

![colors-iphone]

[colors-iphone]: /images/2018-01-13/apple-event-colors-iphone@3x.jpeg

I was hoping for some `displayBacgkroundColor` property on `EKCalendar` object or something similar, but it does not seem to exist. I almost decided to start approximating their algorithm while I realized one thing—the icloud.com site has a calendar "application". The event colors there seem to follow the same logic as those in the Calendar app. They are not strictly the same but it could provide some insight into how the color switching works.

![colors-icloud]

[colors-icloud]: /images/2018-01-13/apple-event-colors-icloud@2x.png

iCloud.com being a modern web application, it runs a bunch of client side JavaScript. Since it is possible to add events, change calendar colors and so on, I assumed that the code which calculates the text and background colors for events must be somewhere in the publicly available JavaScript. There was a small possibility that they pre-computed the colors on the server but this seemed unlikely.

# Homing in on the function

I decided to use Safari for this. It seems kind of appropriate and I am quite familiar with its web developer tools. I open the iCloud website, open the calendar page and look into what kind of JavaScript files are loaded.

Among others, this page loads mainly two big JavaScript files, both called `javascript-packed.js`. The other files are all called `javascript-strings` so I assume these load the localization files or something like that. 

My first hypothesis was that the function is called when a color of an already present event is changed. This might happen when, for example, the calendar to which the event belongs is changed.

Luckily Safari can display minified JavaScript files in indented mode. However searching for functions for strings like "update" gave me too many results. 

Looking at the HTML code of an event, I can observe that its color is inside an inline style attribute and that it changes when I change the calendar. This is good news, as the inspector lets me to put a breakpoint on that.

In the inspector I find the event element, right click on the div in the tree structure and set a breakpoint on *Attribute Modified*

![set-breakpoint]

[set-breakpoint]: /images/2018-01-13/set-breakpoint@2x.png

Now I click on the event in the app, change the calendar... and voilà.

![callstack]

[callstack]: /images/2018-01-13/callstack@2x.png

## Walking up the call stack

At the very end of the call stack I can see that a property is assigned a value of `#a66110`. This is actually the text color for this calendar (I checked this in the inspector). My hope is that it will be calculated somewhere up the stack.

{{< figure src="/images/2018-01-13/callstack-01@2x.png" title="1 style: Assign #a66110 as as the color property of a CSS declaration" >}}
{{< figure src="/images/2018-01-13/callstack-02@2x.png" title="2 anonymous: Function that that applies the CSS style when called" >}}
{{< figure src="/images/2018-01-13/callstack-03@2x.png" title="3 access: This function is a sort of trampoline" >}}
{{< figure src="/images/2018-01-13/callstack-04@2x.png" title="4 css: This function generates the anonymous function in step 2, it does get the #a66110 as a parameter 'n'" >}}
{{< figure src="/images/2018-01-13/callstack-05@2x.png" title="5 updateProperty: calls the css function, and also gets the #a66110 as a parameter 'r'" >}}

When I get to the 6th level I finally hit something interesting. This is where the value `#a66110` is created (inside a function called `_update`:

{{< figure src="/images/2018-01-13/callstack-06@2x.png" title="6 _update: This function seems to update the whole event, its title, state and most importantly, colors" >}}

```js
p = t.get("textColor")
```

The `get` method seems to be doing something akin to the following (I did not really dig into this):

```js
object.prototype.get = function(propName) {
	return call(this, this.properties[propName]);
}
```

I any case, the color value is derived from object `t` and its property `textColor`.

## Finding the 'Event' object

I look into the `t` object's properties and see this:

{{< figure src="/images/2018-01-13/t-object-properties@2x.png" title="" >}}

A cursory glance at the properties confirms to me that this is an 'Event' object. It has the usual ones such as `owner`, `isAccepted` and so on.

Intuitively this line then, in the `_update` function, does what we were searching for: _Get the text color for an event and change the elements css representation to reflect that._

```js
p = t.get("textColor"), this.updateProperty(n, o, ".text", p, "color")
```

I dig into this `textColor` property. I search the JavaScript file for it and look over the few results I get.

Within a piece of code which starts with `Cal.Collection = CoreCal.Collection.extend({` I find this (among the other event properties):

```js
textColor: function() {
    if (this.get("isBirthdayCalendar")) return "#4d5765";
    var e = this.get("_hexColor");
    return Cal.colorController.computeTextColor(e)
}.property("_hexColor").cacheable(),
backgroundColor: function() {
    if (this.get("isBirthdayCalendar")) return "#cfd3d9";
    var e = this.get("_hexColor");
    return Cal.colorController.computeBackgroundColor(e)
}.property("_hexColor").cacheable(),
```

`Cal.colorController.computeTextColor(e)` and `Cal.colorController.computeBackgroundColor(e)` and in both cases `e` is a color... finally I have struck gold!

## Compute text and background color

The function iCloud uses to compute the text color is this:

```js
computeTextColor: function(r) {
    r || CW.fatalError("Cannot provide a text color without a starting color"), r = r.toLowerCase();
    var i = this.get("specialColors"),
        s = SC.convertHexToHsv(r),
        o = s[0],
        u = s[1],
        a = s[2],
        f;
    if (i.isLight(o, u, a)) f = i.light.text;
    else if (i.isDark(o, u, a)) f = i.dark.text;
    else {
        var l = a - n,
            c = i.isGray(o, u, a),
            h = c ? 0 : Math.max(u, e);
        f = SC.convertHsvToHex(o, h, Math.max(l, t))
    }
    return f
},
```

By putting a breakpoint on the `f = ...` line I can deduce the constants `n = 0.35`, `e = 0.5` and `t = 0.3`.

As for the background color:

```js
computeBackgroundColor: function(e) {
    if (!e) {
        SC.error("Cannot provide a background color without a starting color");
        return
    }
    e = e.toLowerCase();
    var t = this.get("specialColors"),
        n = t.backgrounds[e];
    if (n) return n;
    var r = SC.convertHexToHsv(e),
        i = r[0],
        o = r[1],
        u = r[2];
    if (t.isLight(i, o, u)) n = t.light.background;
    else if (t.isDark(i, o, u)) n = t.dark.background;
    else {
        var a = t.isGray(i, o, u) ? 0 : s;
        n = SC.convertHsvToHex(i, a, t.bgBrightness(i, o, u))
    }
    return n
},
```

And the contents of the `specialColors` are here (comments are from my investigation of constants):

```js
specialColors: {
    light: {
        main: "#dddddd",
        text: "#a8a8a8",
        background: "#f8f8f8"
    },
    dark: {
        main: "#1a1a1a",
        text: "#000000",
        background: "#bababa"
    },
    titles: {
        "#cc73e1": "#b14bc9",
        "#65db39": "#49bf1f",
        "#ffcc00": "#e0ac00",
        "#ff9500": "#ff7f00"
    },
    backgrounds: {
        "#a2845e": "#e0d3c1"
    },
    isLight: function(e, t, n) {
        var s = Cal.colorController;
        return n > r && t < i // r = 0.6, i = 0.1
    },
    isDark: function(e, n, r) {
        return r < t // t = 0.3
    },
    isGray: function(e, t, n) {
        return t < i // i = 0.1
    },
    bgBrightness: function(e, t, n) {
        return Math.min(n * 1.5, o)
    }
},
```

Then there is a bunch of color conversion functions that work in a pretty standard way.

- `convertHsvToHex` takes a R, G, B triplet and returns a `[H, S, V]`
- `convertHexToHsv` takes an array of three elements `[H, S, V]` and returns an array `[R, G, B]`
- two regexes to check if a colors is in the HTML `rgb(r, g, b)` or `#RRGGBB` format
- `parseColor` which converts either of the two formats and returns a `#RRGGBB` representation
- `expandColor` which takes the `#RRGGBB` color and returns an array of `[R, G, B]`
- `toColorPart` which takes a number in 0-255 range and transforms it to hex representation

I am not going to detail these functions here, but I have uploaded them here if you would like to look:

[Original Apple Conversion Functions](/files/downloads/2018/original-apple-conversion-functions.js)

# Rewriting the functions into more human readable format

These functions were of course at least partly generated and minified. So I have rewritten them into a digestible format.

First, I have written a `colorTools` object which has the properties from the `specialColors` object on iCloud.

```js
const colorTools = {
  light: {
    text: "#a8a8a8",
    background: "#f8f8f8"
  },
  dark: {
    text: "#000000",
    background: "#bababa"
  },
  backgrounds: {
    "#a2845e": "#e0d3c1"
  },
  isLight: function(h, s, v) {
    return v > 0.6 && s < 0.1
  },
  isDark: function(h, s, v) {
    return v < 0.3
  },
  isGray: function(h, s, v) {
    return s < 0.1
  },
  bgBrightness: function(h, s, v) {
    return Math.min(v * 1.5, 1)
  },
  /* color space conversion removed for brevity */
```

This object is then used as a helper for the two functions I was actually searching for in the beginning.

## Text Color

If the color is too light or too dark then use a pre-computed text color. Otherwise cap the saturation to 0.5 (for grayish colors just set it at 0) and reduce the value by 0.35.

```js
function computeTextColor(rgb) {
  const [h, s, v] = colorTools.convertHexToHsv(rgb);  
  if (colorTools.isLight(h, s, v)) {
    return colorTools.light.text;
  } else if (colorTools.isDark(h, s, v)) {
    return colorTools.dark.text;
  } else {
    const rs = colorTools.isGray(h, s, v) ? 0 : Math.max(s, 0.5);
    const rv = v - 0.35;
    return colorTools.convertHsvToHex(h, rs, Math.max(rv, 0.3))
  }
}
```

## Background color

In a similar fashion, use a pre-computed colors if the background is too light or dark. Set the saturation to 0 for grayish colors.

```js
function computeBackgroundColor(rgb) {
  if (colorTools.backgrounds[rgb]) {
    return colorTools.backgrounds[rgb];
  }
  const [h, s, v] = colorTools.convertHexToHsv(rgb);
  if (colorTools.isLight(h, s, v)) {
    return colorTools.light.background;
  } else if (colorTools.isDark(h, s, v)) {
    return colorTools.dark.background;
  } else {
    let rs = colorTools.isGray(h, s, v) ? 0 : s;
    return colorTools.convertHsvToHex(h, rs, colorTools.bgBrightness(h, s, v));
  } 
}
```

This was fun. Now, the colors on iCloud website are not strictly the same than in the iOS app, but that requires just a bit of tweaking with the constants.

You can download the complete JavaScript file I have extracted here:

[Apple Calendar Colors](/files/downloads/2018/apple-calendar-colors.js)

# Some final words

There you have it. In the end I was actually surprised that it was pretty easy to extract these functions from the code. I expected the minified/obfuscated code to be quite hard to read. Interestingly, most function names did not get mangled. I suppose this is due to the fact that they are called through strings in some part of the framework Apple uses.

Of course, later I have converted these functions into Swift UIColor extensions so I can use them in my [application](https://itunes.apple.com/us/app/eventail/id959674103?mt=8).

I might publish them here sometime later, but if you are interested ask me on Twitter.

