---
title: "Creating Sf Symbols with Affinity Designer"
date: 2020-07-18T19:54:10+02:00
layout: post
draft: true
categories: Eventail
tags:
  - Swift
  - Xcode
  - iOS
---

Creating SF Symbols is supposed to be easy. Create a template using SFSymbols app. Modify the SVG and import in Xcode. It is all documented [here][sfsymbols].

SFSymbols template requires you to manually create and adjust images for all weights and sizes. This is fine if your image has lines that need to follow the weight. Many of them don't or could auto scale.

Nevertheless I've made this Affinity Designer template that you can use. Open it, edit the one symbol it contains (called Template) and you are all set.

![ss-affinity]

[⬇ sfsymbol-template.afdesign][dl-template]


Unfortunately although Affinity Designer produces a perfectly valid SVG—and it will get validated by SFSymbols—Xcode does not like it.

This is what Affinity exports:

```xml
<g transform="matrix(1.22074,0,0,1.22074,498.674,600.389)">
   <g id="Ultralight-S">
```

This is what Xcode wants:

```xml
<g id="Ultralight-S" transform="matrix(1.22074,0,0,1.22074,498.674,600.389)"> 
```

Alright, let's do Perl:

```perl
#!/usr/bin/perl
my $file = $ARGV[0];
open FILE, $file or die "Failed to open file: $!";
$/ = undef;
my $xml = <FILE>;
close FILE;
my @weight = (
  "Ultralight", "Thin", "Light", "Regular", "Medium",
  "Semibold", "Bold", "Heavy", "Black",
);
my @size = ("S", "M", "L");
for my $w (@weight) {
  for my $s (@size) {
    $xml =~ s/<g (transform=[^>]+?)>\s+<g (id="$w-$s")>(.*?)<\/g>/<g \2 \1> \3/s;
  }
}
print($xml, "\n");
```

This will finally transform the SVG into a format that Xcode will swallow.

[⬇ fix-sfsymbol.perl][dl-script]

[sfsymbols]: https://developer.apple.com/documentation/uikit/uiimage/creating_custom_symbol_images_for_your_app
[ss-affinity]: /images/affinity-sfsymbols.png
[dl-template]: /files/downloads/sfsymbol-template.afdesign
[dl-script]: /files/downloads/fix-sfsymbol.perl


