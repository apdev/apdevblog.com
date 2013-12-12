---
title: Loader.close() Bug inside Flash IDE
author: Aron
layout: post
date: 2007-12-15 00:00:00 +0100
comments: true
permalink: /loaderclose-bug-inside-flash-ide/
categories:
  - Flash
tags:
  - ActionScript
  - charles
  - Flash
  - IDE
  - loader
---
In AS3 you finally have the possibility to close a Loader request using the Loader.close() function. The so far loaded data is cached, so when you initialize a new Loader it continues. This is working pretty well.

But: Not inside the Flash IDE! It took me hours to find out. Yeah, i know, i should have known better&#8230; :) So don&#8217;t worry, inside the Browser it works just fine.

BTW: We&#8217;re using <a href="http://www.xk72.com/charles/" title="Charles Proxy" target="_blank">Charles</a> to test the preloading functionality. Charles also allows you to protocol the sent and received remoting data both inside the Flash IDE and Browser (Firefox / IE). Charles is not free, but it&#8217;s worth the money! 