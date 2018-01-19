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

*Edit 2018-01-19*
 
In my original article I have naively supposed that the group names are not localized. This is false. Always use the Well Known Security IDs when manipulating permissions on Windows.

---

I've spent good part of my morning trying to find a way how to set permissions to a particular group.

Finally while digging though Stack Overflow I have found [this question][1] which lead to [another][2] because of deprecation errors.

[1]: https://stackoverflow.com/questions/910528/how-to-change-the-acls-from-c
[2]: https://stackoverflow.com/questions/1095745/am-i-using-setnamedsecurityinfo-incorrectly-the-acl-of-my-file-doesnt-seem-to

My final version of the code to _add_ file _read_ and _write_ permissions to the group _Users_ is this:

```c++
#include <Windows.h>
#include <AccCtrl.h>
#include <Aclapi.h>

const char* fileName = "C:/path/to/your_file.txt";

DWORD result = 0;

PACL pDACL = NULL;
PACL pOldDACL = NULL;
PSECURITY_DESCRIPTOR pSD = NULL;
EXPLICIT_ACCESS ea;
PSID pUsersSID = NULL;

const auto cleanup = [pDACL, pOldDACL, pSD, pUsersSID](){
  if (pOldDACL) LocalFree(pOldDACL);
  if (pDACL) LocalFree(pDACL);
  if (pSD) LocalFree(pSD);
  if (pUsersSID) FreeSid(pUsersSID);
};

result = GetNamedSecurityInfo(static_cast<LPTSTR>(fileName), SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, NULL, NULL, &pOldDACL, NULL, &pSD);
if (result != ERROR_SUCCESS) {
  std::cerr << "Failed to get the security info [" << result << "]" << std::endl;
  cleanup();
  return EReturnCode_Error;
}

ZeroMemory(&ea, sizeof(EXPLICIT_ACCESS));

SID_IDENTIFIER_AUTHORITY SIDAuthNT = {SECURITY_NT_AUTHORITY};
if (!AllocateAndInitializeSid(&SIDAuthNT, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_USERS, 0, 0, 0, 0, 0, 0, &pUsersSID)) {
  std::cerr << "Failed to allocate SID" << std::endl;
  cleanup();
  return EReturnCode_Error;
}

ea.grfAccessPermissions = FILE_GENERIC_WRITE | FILE_GENERIC_READ;
ea.grfAccessMode = SET_ACCESS;
ea.grfInheritance = CONTAINER_INHERIT_ACE | OBJECT_INHERIT_ACE;
ea.Trustee.TrusteeForm = TRUSTEE_IS_SID;
ea.Trustee.TrusteeType = TRUSTEE_IS_WELL_KNOWN_GROUP;
ea.Trustee.ptstrName = reinterpret_cast<LPTSTR>(pUsersSID);

result = SetEntriesInAcl(1, &ea, pOldDACL, &pDACL);
if (result != ERROR_SUCCESS) {
  std::cerr << "Failed to set entries in the access control list [" << result << "]" << std::endl;
  cleanup();
  return EReturnCode_Error;
}

result = SetNamedSecurityInfo(static_cast<LPTSTR>(fileName), SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, NULL, NULL, pDACL, NULL);
if (result != ERROR_SUCCESS) {
  std::cerr << "Failed to set the security info [" << result << "]" << std::endl;
  cleanup();
  return EReturnCode_Error;
}

cleanup();
```

Note: You will also need to link your program with `Advapi32.lib`.

---

My original code follows, do _not_ use this:

{{< highlight "c++" >}}
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
{{</ highlight >}}

