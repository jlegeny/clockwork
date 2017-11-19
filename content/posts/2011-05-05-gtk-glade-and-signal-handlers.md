---
layout: post
title:  "Gtk, Glade and signal handlers in C++"
date:   2011-05-05 08:00:49
categories: Hacks
tags:
- c++
- Glade
- Gtk
---

Much was written about connecting signal handlers to interfaces made with Glade
and imported with GtkBuilder. The problem is that everybody uses a different
system and/or language. So here is a guide which explains all the magic:

## Glade Interface

First of all create your widget in Glade and assign it a signal handler. We are
going to create a very simple application which has a single button which exits
it. The Glade interface should look something like this. It is basically a Main
Window (main\_window) widget with a Button (exit\_button) inside. We define a
handler for the signal "clicked" for the button and call it
exit\_button\_handler.

![glade-interface-example]

## C++ code

Now let's create the source file, it looks like this. As you can see our signal
handler is just a basic void returning function.

```c++
#include <gtk/gtk.h>

extern "C" G_MODULE_EXPORT void exit_button_handler(GtkObject* caller, gpointer data)
{
    gtk_main_quit();
}

int main(int argc, char ** argv)
{
    gtk_init(&amp;argc, &amp;argv);
    GtkBuilder* l_BuilderInterface = gtk_builder_new();
    gtk_builder_add_from_file(l_BuilderInterface, "ui.glade", NULL);
    gtk_builder_connect_signals(l_BuilderInterface, NULL);
    gtk_widget_show(GTK_WIDGET(gtk_builder_get_object(l_BuilderInterface, "main_window")));
    gtk_main();
    return 0;
}
```

The important thing to notice is that the declaration of the callback function
is preceded by `extern "C" G_MODULE_EXPORT`. These two bits of code ensure that
the produced object will have a C-compatible table-entry for this function even
though we are using a C++ compiler and that it will be accessible under Windows
as well. Indeed, the `G_MODULE_EXPORT` macro expands to nothing under Linux.

## Compilation

Now, we need to compile the whole thing. Let's say we have called the file
above *main.cpp*. The line to call on Linux would be :

    g++ `pkg-config --cflags --libs gtk+-2.0 gmodule-2.0` main.cpp -o test

Let's look at the output of the pkg-config file for a while :

    -pthread -I/usr/include/atk-1.0 -I/usr/include/pango-1.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/freetype2 -I/usr/include/libpng12 -I/usr/include/gtk-2.0 -I/usr/lib/gtk-2.0/include -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/pixman-1  -pthread -Wl,--export-dynamic -L/usr/lib/x86_64-linux-gnu -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lm -lcairo -lpango-1.0 -lfreetype -lfontconfig -lgobject-2.0 -lgthread-2.0 -lgmodule-2.0 -lrt -lglib-2.0

That's a lot of stuff! Depending on the system your mileage can vary,
but the important bit is : `-Wl,--export-dynamic`. This piece of code
ensures that you will be actually able to find the symbol once it is
needed. On Windows, there is no need for the --export-dynamic flag, just
be sure to load the *gtk* library as well as the *gmodule*. And that's
it, done and done!

[glade-interface-example]: /images/ui.glade.png "The UI inside Glade"
