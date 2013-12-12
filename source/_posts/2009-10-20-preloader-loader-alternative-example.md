---
title: PreLoader (our Loader alternative) Example
author: Aron
layout: post
date: 2009-10-20 00:00:00 +0100
comments: true
permalink: /preloader-loader-alternative-example/
syntaxhighlighter_encoded:
  - 1
categories:
  - Misc
tags:
  - ActionScript
  - loading
  - PreLoader
---
<a href="http://apdevblog.com/examples/apdev_preloader/" target="_blank"><img src="/images/img/preloader_img.jpg" /></a>

Some of you guys asked, why even using the PreLoader instead of the original Loader from Adobe in the first place. The PreLoader queues the load requests, that&#8217;s all&#8230; :) [Read the full story here][1].

For quick starters here an super simple example, that illustrates what we&#8217;re talking about:  
<a href="http://apdevblog.com/examples/apdev_preloader/"  target="_blank">PreLoader simple example</a>. You might want to use something like [charles][2] to throttle down your bandwidth.

This example is also to be found the in [PreLoader repository][3].



 [1]: http://apdevblog.com/as3-open-source-preloader/
 [2]: http://www.charlesproxy.com/
 [3]: http://code.google.com/p/as3-preloader-queue/source/browse/trunk/com/apdevblog/example/PreLoaderExample.as