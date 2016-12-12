---
layout: post
title:  "Push irssi away messages to your iPhone"
date:   2012-04-14 16:05:12
categories: Knacks
tags:
- iOS
- iPhone
- irssi
- push
---

Using irssi for IRC is quite a must. Add some [bitlbee][lnk-bitlbee] sweetness
and you have everything you need for your instant messaging needs. With a handy
ssh application like iSSH you will get to a cyborg state when you are always
connected. Small problem arises when compared to other IM applications, like
IMO, that is that there are no notifications available and you will probably
miss a lot of conversations. Fear not, however, for there is a solution for
every problem.

[lnk-bitlbee]: http://www.bitlbee.org/main.php/news.r.html

## Push notification application

First, you will need an application to get any push notification to your phone.
There are several of them, I would recommend using the [Push4][lnk-push4].
There is a free version if you want to test it first. Once you have installed
it and created an account go to your account settings on your website and go to
My Account -> Settings -> Profile to get your API key. You can also make the
application send you an e-mail with the key.

[lnk-push4]: http://www.appnotifications.com/ "Notifications App"

## Some scripting

You will need to make two scripts to send the notifications. (You could manage
with less, of course, but I am too lazy). First one is a bash script which uses
curl to send a notification to your phone. Here it is :

    curl -d "user_credentials=YOUR_API_KEY" \
     -d "notification[message]=$1" \
     -d "notification[long_message]=$2" \
     -d "notification[title]=New irssi notification" \
     -d "notification[subtitle]=irssi message" \
     -d "notification[long_message_preview]=$1" \
     -d "notification[message_level]=2" \
     -d "notification[silent]=0" \
     -d "notification[action_loc\_key]=OK" \
     -d "notification[sound]=1" https://www.appnotifications.com/account/notifications.json

Do not forget to replace the YOUR\_API\_KEY by your real API key.

You can test the script immediately, although it might not work for a few hours
just after your Push4 account creation. Basically this script sends you a
notifications with first parameter as short text preview and second as a long
text (which can use HTML markup). A second script is needed to parse the
awaylog and send notifications using the first script.

    #!/usr/bin/perl -n use HTML::Entities;
    if (/(\d+:\d+) (?:([#&][^ ]+)+:)?.*?\/.*?\/(.*?).g.8.*?e(YOURNICK: )?(.*)/) {
        $time = $1;
        $channel = $2;
        $sender = $3;
        $message = $5;
        $message =~ s/\\/:/g;
        $message =~ s/"/\\"/g;
        $message =~ s/[;&]/:/g;
        print `./irssi_notify.sh "$sender : $message at $time" "Message from <b>$sender</b> (<i>$channel</i>) at <b>$time</b> : $message"\n`;
    }

Now, to clarify things a bit. What this script does is that it takes some
input, and if it is in some format, `/(\d+:\d+) (?:([#&][^ ]+)+:)?.\*?\/.\*?\/(.\*?).g.8.\*?e(YOURNICK: )?(.*)/`, to be precise, it will
parse it and send it via a notification. Note that this works if you did not
play with your irssi theme too much, as the awaylog basically copies the format
of public and highlight messages. The (YOURNICK: )? part is optional, and it
helps to remove the usual prefix of highlight messages. I can not help you much
with the regex, you have to find one on your own or you can use this script
which basically takes anything in awaylog and sends it as it is (it works well
and everywhere).

    #!/usr/bin/perl -n use HTML::Entities;
    $message = encode_entities($_);
    $message =~ s/\\/:/g; $message =~ s/"/\\"/g;
    $message =~ s/[;&]/:/g; print `./irssi_notify.sh "$message" "$message"\n`;

## Making it all work

Let us run the machine now. You will need to start another screen to run this
(if somebody will help me with making a nohup version of the command I will
gladly have it). Run a terminal on your shell and run

    screen bash tailf ~/.irssi/away.log | perl irssi_notify.pl

Now detach the screen and you are on the roll.

---

*Edit 2015-10-17*

The Push4 service is no longer available. I am currently using a solution that
uses *Pushover*. I'll write up an article on how to use that shortly.


