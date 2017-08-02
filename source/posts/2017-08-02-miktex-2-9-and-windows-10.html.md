---
layout: post
title: MiKTeX 2.9 and Windows 10 package installation woes
date: 2017-08-02 15:42:08 UTC
category: Knack
tags:
- MiKTeX
- Windows
---

Today my MiKTeX installation stopped installing packages on the fly. After trying to install packages through Package Manager I found out that this did not work either. The error that I have obtained is this:

    The executed process did not succeed.
    fileName="C:\Program Files (x86)\MiKTeX 2.9\MiKTeX\bin\initexmf.exe", arguments=" --mklinks --mkmaps", exitCode="1"
{: .bash}


I googled around and found out that this might be a problem with the installation folder not being accessible and the suggested solution was to install MiKTeX somewhere else (or just for the local user). This was not an option for me as a toolchain that does not depend only on me requires the latex binary to be in the default folder.

My solution was to go to the `C:\Program Files (x86)\MiKTeX 2.9` folder properties and changing the **Users** permissions to **Full Control**. Not extremely secure but at least now I can build my documentation.