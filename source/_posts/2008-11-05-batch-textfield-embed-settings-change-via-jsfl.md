---
title: Batch textfield embed settings change via jsfl
author: Aron
layout: post
date: 2008-11-05 00:00:00 +0100
comments: true
permalink: /batch-textfield-embed-settings-change-via-jsfl/
categories:
  - Flash
tags:
  - batch
  - embed settings
  - Flash
  - IDE
  - jsfl
---
Recently we had the problem to change the embed setting of tons of textfields instances inside of at least a gazillion MovieClips. We got the FLA-file from a designer (we maybe haven&#8217;t briefed enough&#8230; :) ) and wanted to use them in a lib swc for a AS3-only project. So we started to change them &#8220;by foot&#8221;, internship work, damn it!

Finally we came up with the idea to write a jsfl script which does the job.

There you go: [Change Textfield Embed Settings.jsfl][1]  
As zip: [ChangeTextfieldEmbedSettings.zip][2]

Copy the file inside the command folder here:

Mac: /[user]/Library/Application Support/Adobe/Flash CS3/en/Configuration/

Windows: \Documents and Settings\<username>\Local Settings\Application Data\Adobe\Flash CS3\language\Configuration\

How to use:

Create a dummy TextField on the timeline and set it to the embed setting you want to apply to all TextField instances of all MovieClip timelines inside the library. Make sure that this TextField has the same font name as the TextFields you want to apply the setting to. Select this TextField and run the script by clicking &#8220;Change TextField Embed Setting&#8221; inside the Command menu of Flash.

The script now opens every MovieClip of the library and searches for TextField instances. If found and the font matched with the previously created dummy TextField, the new embed setting will be copied.

Note: The script only works with MovieClip library items and TextField of the type &#8220;dynamic&#8221; or &#8220;input&#8221;. Only the embed settings of the dummy TextField will be applied, all other properties will be ignored. 

 [1]: /stuff/Change Textfield Embed Settings.jsfl
 [2]: /stuff/ChangeTextfieldEmbedSettings.zip