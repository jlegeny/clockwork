---
title: "Setting File Permissions on Windows With C"
date: 2017-11-30T11:07:22+01:00
layout: post
category: Hacks
tags:
 - C++
 - Windows
 - WinAPI
---

I've spent good part of my morning trying to find a way how to set permissions to a particular group.

Finally while digging though Stack Overflow I have found [this question][1] which lead to [another][2] because of deprecation errors.

[1]: https://stackoverflow.com/questions/910528/how-to-change-the-acls-from-c
[2]: https://stackoverflow.com/questions/1095745/am-i-using-setnamedsecurityinfo-incorrectly-the-acl-of-my-file-doesnt-seem-to

My final version of the code to _add_ file _read_ and _write_ permissions to the group _Users_ is this:

```c++
const char* fileName = "C:/path/to/your_file.txt";

PACL pDACL = NULL;
PACL pOldDACL = NULL;
PSECURITY_DESCRIPTOR pSD = NULL;
EXPLICIT_ACCESS ea;

GetNamedSecurityInfo(static_cast<LPTSTR>(fileName), SE_FILE_OBJECT,
                     DACL_SECURITY_INFORMATION, NULL, NULL,
                     &pOldDACL, NULL, &pSD);

ZeroMemory(&ea, sizeof(EXPLICIT_ACCESS));

char groupUsersName[6] = {"USERS"};
ea.grfAccessPermissions = FILE_GENERIC_WRITE | FILE_GENERIC_READ;
ea.grfAccessMode = SET_ACCESS;
ea.grfInheritance = CONTAINER_INHERIT_ACE | OBJECT_INHERIT_ACE;
ea.Trustee.TrusteeForm = TRUSTEE_IS_NAME;
ea.Trustee.TrusteeType = TRUSTEE_IS_GROUP;
ea.Trustee.ptstrName = groupUsersName;

SetEntriesInAcl(1, &ea, pOldDACL, &pDACL);

SetNamedSecurityInfo(static_cast<LPTSTR>(fileName), SE_FILE_OBJECT,
                    DACL_SECURITY_INFORMATION, NULL, NULL, pDACL, NULL);
```

Note: You will also need to link your program with `Advapi32.lib`.