---
title: "CSS Classes in Pure Markdown"
date: 2020-04-27T08:00:00+02:00
layout: post
categories: Hacks
tags:
- CSS
---

One of Markdowns design choices is to not implement any layout.

# Problem

![illustration]

One thing I wish it had would be a way of specifying image positions. E.g.: float on right and have width equal to the third of the column. Just like the example illustration somewhere next to this text.

Markdown does support plain html tags, so a verbatim `<img>` tag would be a solution. I find this inelegant, however. Various markdown processors support their own way to add classes, or have their own layout engine. As I prefer to keep my markdown as close to the GitHub style as possible, this is not an option for me.

# Solution

I have already explored the use of the `$=` selector for the `src` attribute in my [previous article][post-retina-images].

Now let us take this approach a bit further. We declare the CSS like this:

{{< highlight css >}}
img[src*="+right"] {
  float: right;
  margin-left: 20px;
}
    
img[src*="+third"] {
  width: 30%;
}
{{</ highlight >}}

This allows us to add classes in markdown inside location hashes.

```markdown
The following image will be floating on the right.

![illustration]

[illustration]: http://example.com/illustration.png#+right+third
```

And that is all there is to it.

[post-retina-images]: /2018/01/pure-css-solution-to-retina-images-with-a-single-file/

[illustration]: /images/2020-04-27/illustration.jpg#+right+third
