---
layout: post
title: Unprotect password protected Word documents
date: 2016-10-22T13:13:43Z
categories: Knacks
tags:
- Security
---

It is always annoying when people expect you to collaborate with them and they send you locked files.

This trick only works for documents that are protected for **Review**. Not when you can not even open them.

So, let us assume you have a `Protected.docx` file that looks something like this. Notice the disabled *Delete Comment*, *Accept Changes* and so buttons.

![Sad grey icons](/images/unprotect-word/protected-document.png)

## Step 1: Open the box

A good thing to know is that .docx (and .xlsx) files are just zipped folders. 

Rename the `Protected.docx` file to `Protected.zip` and unzip it. You will obtain something that looks like this:

![Docx folder contents](/images/unprotect-word/file-contents.png)

## Step 2: Tinker with the contents

Open the file `word/settings.xml`. Its contents will look somewhat like this (except there will be more of it and everything will be on the same line):

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:settings xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml" xmlns:sl="http://schemas.openxmlformats.org/schemaLibrary/2006/main" mc:Ignorable="w14 w15">
  <w:zoom w:percent="100"/>
  <w:proofState w:spelling="clean" w:grammar="clean"/>
  <w:trackRevisions/>
  <w:documentProtection w:edit="trackedChanges" w:enforcement="1" w:cryptProviderType="rsaFull" w:cryptAlgorithmClass="hash" w:cryptAlgorithmType="typeAny" w:cryptAlgorithmSid="4" w:cryptSpinCount="100000" w:hash="1+kEXOhPYpKExv2F8dIx9VCN5Ps=" w:salt="aOdV7QoW4ZJW3KVDxd7jBg=="/>
  <w:defaultTabStop w:val="720"/>
  <w:characterSpacingControl w:val="doNotCompress"/>
  <w:savePreviewPicture/>
  <w:compat>
    <w:useFELayout/>
 ...
```

Notice the

```xml
<w:documentProtection w:edit="trackedChanges" w:enforcement="1" w:cryptProviderType="rsaFull" w:cryptAlgorithmClass="hash" w:cryptAlgorithmType="typeAny" w:cryptAlgorithmSid="4" w:cryptSpinCount="100000" w:hash="1+kEXOhPYpKExv2F8dIx9VCN5Ps=" w:salt="aOdV7QoW4ZJW3KVDxd7jBg=="/>
```
    
this is the source of our woes. Now, simply remove the characters between `<w:documentProtection` and the first `/>` you encounter after it. Save the file.

## Step 3: Put the box back together

Now, zip the folder back again. It is important that you compress the files as they were: the folders `word`, `_rels`, `docProps` and the file `[Content_Types].xml` are on the top level of the zip (i.e.: not in a subfolder that was probably created when you unzipped the original file). Let us call the new file `Unprotected.zip`

Finally, rename the file back to `Unprotected.docx`.

## Step 4: Look into the box

And voilà:

![Sad grey icons](/images/unprotect-word/unprotected-document.png)

Note: Word might complain about the document being corrupted, simply choose *Open Anyway* and re-save the file again.
