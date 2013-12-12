---
title: Dear iOS developer, please collect the garbage (the other one)
author: Aron
layout: post
date: 2010-08-20 00:00:00 +0100
comments: true
permalink: /ios-the-other-garbage-collection/
categories:
  - Misc
tags:
  - iOS
  - iOS dev
  - iPhone dev
---
![][1]  
<a style="font-size: 10px;" href="http://www.flickr.com/photos/oskaline/" target="_blank">Paper basket image by oskaline via Flickr</a>

Some time ago I wrote a blog [post about fixing slow iTunes backup][2]. The article became the by far most visited one on this blog and we are still getting tons of visitors from google every day. When reading the comments you can see that lots of users seem to have the same/similar problem.

<!--more-->

The issue results from the fact, that some apps **save lots of files to the file system** of the iPod Touch, iPhone or iPad. While &#8211; of course &#8211; nothing speaks against using the file system to save data, the **problem starts when files getting to many**. iTunes then needs ages to copy them to the computer when doing a sync (the backup before the sync in particular).

If using a reasonable number of files you will never have a problem. However, if your app syncs data from the web (for instance a news or rss reader) make sure that you delete the read / no longer needed files. Please :)

The usual customer otherwise might have the feeling the iPhone &#8220;doesn&#8217;t work&#8221; anymore. Or even worse, the customer reads [our article][2] and blames your app in [the comments][3]&#8230; :)

PS: Personally, I haven&#8217;t worked on apps that make extensive use of the file system. If you have, feel free to share your experiences. 

 [1]: http://farm1.static.flickr.com/36/84970969_68529bd4f1.jpg
 [2]: http://apdevblog.com/slow-itunes-sync-backup/
 [3]: http://apdevblog.com/slow-itunes-sync-backup/#comments