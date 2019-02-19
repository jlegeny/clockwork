---
title: "A few things to consider before localising your application"
date: 2019-02-18T16:01:37+01:00
layout: post
categories: Eventail
tags:
---

Your application is finished and uploaded to the App Store. You are happy and eager to see the reactions from customers. Then, a review like this lands in:

<div style="max-width:8cm;background:#f5f5f5;text-color:#222;border-radius:10px;padding:15px;box-shadow:2px 2px 20px #444">
<p><strong>Spanish,please</strong> <span style="color:#fa1">★★★☆☆</span><br/>
by disappointed person – Feb 16, 2019</p>
<p>Cuándo será en español, la compraré....</p>
</div>

After a few dozens of such reviews, you may be tempted to translate the application into another language. In this article I will point out a few reasons why that might be a bad idea and give a few pointers for when you decide to pass the hurdle.

<aside class="note">Note: I am writing this from a perspective of a solo iOS developer. Things are different if you work in a massive company that has a department dedicated to internationalisation, but the platforms, be it Android or Windows do not matter.</aside>

# Translation may bring other people into the churn

Working alone on an app makes a things easy and agile—writing new features and fixing bugs takes little time and once they are written nothing stops you from releasing the new version.

If you translate the application into a language that you do not master yourself, you need to bring in translators and to depend on them. This ties to someone else's schedule every time you modify a visible text in the application.

_Someone else_ might be on vacation, they might be sick or have other stuff to do and will not scramble to translate things for you. You have to plan the releases around their availabilities.

# Translation brings additional (boring) work

I assume that you have thought about internationalisation from the beginning and that your code uses [localisable strings][trn-api] everywhere. If it does not, this should be done before any translating can start.

[trn-api]: https://developer.apple.com/documentation/foundation/nslocalizedstring

You will have to translate all of the strings in the application and the whole UI. Be aware than many terms that are common in English are do not always have counterparts in other languages. This concerns a lot of technical and computer related vocabulary. This means that you will need to do due diligence to find out what terms are colloquially used in the target language for what you wish to describe.

Some languages handle the context differently from others: A menu with a lot of switches may only require a short label in front of each switch in English, but demand longer descriptions when translated. This may require alterations to the UI because the labels might no longer fit in the original space.

Once your application has been translated, you are halfway done. You also have to think about screenshots, documentation, marketing material[^mm] and the website.

[^mm]: e.g.: App Store description, change logs


# Translation is a commitment

Features which modify visible text will generate more work from now on. Screenshots, for example, are required for each supported language. Depending on your platform, their generation can be automated by tools such as [fastlane][fastlane][^widgets].

Be prepared to find yourself in a situation when you have finished the features, fixed the bugs, and are ready to submit, only to realise that you have forgot to translate the one button which you have added. If you are using translators, pray that they are not on vacation.

Expect to receive support mail in foreign languages. If you have used an external translator, you may not be able to answer them.

[fastlane]: https://fastlane.tools

[^widgets]: Sadly it does not work for everything—I am looking at you, Today Widgets on iOS.

# A few hints for future polyglots

If you have considered the above and are ready to start translating I can give you a few hints:

## Minimise text in your application

Put as few labels as possible into your applications. Consider them like you consider code, if it exists it must be maintained.

I have removed some settings from my app at the last minute, so I would not have to translate the associated controls. If a feature is hard to explain in a foreign language, it might be too complex to use as well.

If a label can be replaced by a pictogram do so. A good example would be to use a slider with small and large character at either side rather than listing text sizes.[^text-size]

[^text-size]: Something that I though about too late when writing Eventail, but it is on the roadmap.

## Use textual representation for your translated strings

In iOS, you can use full Storyboards or string lists for translating the UI. Stick with the plain text lists as they are easy to diff and mistakes in them are quick to spot.

Localisation will live next to the code in your SCM repository and it is important that its format be adapted.

## Make the non-translated strings pop

Use a gibberish placeholder for untranslated strings and add them immediately after you create each new string. Most frameworks will use the default (usually English) label for non translated strings and this can lead to forgotten translations.

# Closing words

Translating an application might seem to be a good way to increase the number of possible clients and profit. But consider what you are giving up: having an application developed by a single person in a single language gives you incredible flexibility. This agility might be worth more than a satisfying few angry customers.