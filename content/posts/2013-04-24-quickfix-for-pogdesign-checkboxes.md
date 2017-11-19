---
layout: post
title:  "Quickfix for pogdesign checkboxes"
date:   2013-04-24 00:11:17
categories: Enhancements
tags:
- CSS
- Firefox
- Stylish
- TV shows
---

I got finally fed up with the Unity-like checkboxes on my favourite [TV-show
tracking site][1]. Quick roundup: these checkboxes are represented by a box
with a grey checkmark when unchecked and a box with green checkmark when
checked.

Not only is this horrible for colorblind people, it also drives sane persons
nuts.

If you use Stylish extension for firefox, or some alternative for your browser
then you can use this snippet to replace them with standard controls:

```css
@namespace url(http://www.w3.org/1999/xhtml);

@-moz-document url-prefix("http://www.pogdesign.co.uk/cat") {

 .lists div label, .day .ep label, .today .ep label  {
   /* bright background */
   background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAsCAYAAACzBUKoAAABJElEQVQ4je2TscqDQBCEZyWPFiFgYymWKXyGvEEsfISAvdilFCEEJEXeIU0KO0vhlttcqpOY8POvRboMHNcMyzAfQ6fTyQVBAP+IaPqJCDM1TeOg0PV6dYExRuOFiCBgZpXZWgv1ZWZeaNbGWGQ2xiw0W2vVMWi/3ztP65XeK1X/VuM4Qo17t9upcOd5/j/uLMscoMC93W7d4/EA8IY7iqJZnDRNnbUWIjK1MZmNMdhsNg4A4jh2zAxmRlmW5M0rH4OZISIIw9AZYyAiqOt6qmOG+3w+k7/GzDgej7PePnB3XUfMjLZt3wr+A/flcvkw+hi0Xq/VuOl+v+vXfbvdVLiHYfite9KX111VlX7dfd/r110UhQr34XD4rXvSl9edJIka9xPBTXfNN90QEQAAAABJRU5ErkJggg==') !important;

   /* dark background */
   /* background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAsCAYAAACzBUKoAAABJ0lEQVQ4je2TsY2FMBAF1+g6oAJSEpqgCEqhAwgogQpogYScyBkRBA6IIETyCuMfLQLj01+Cy86ShVYeW0+Mnui6zgZBALSFEOdXCAG31batBcbq+94GWmsOC8YYCBCRBe/7DuyXEfElzI3xCtZav4T3fWfHEEVRWLJ1tXe1Svtn2zZg687znKW7LMvvupdlsQAM3QQCOLqvB775oZuAKxiGoThhN4YPfMDXA9/80E2AC56wq9sHUgyRpilbt1BK8ds9jiNL97qu/+0+1x+3u2kafrvneea3u6oqlu66rr/rVkrx2j1Nkz2OAwAc3VLKW5xhGKwxBgh+6KYLUkqLiICIEEXR7+2mC9ZaiOPY3+4kSW7/yZ0fuglwwRN2dftAiiGyLGPr/gDD7TWBmCHgngAAAABJRU5ErkJggg==') !important; */

 }
}
```


If you use a dark background then un-comment the second background-image tag.

Enjoy

 [1]: http://www.pogdesign.co.uk/cat
