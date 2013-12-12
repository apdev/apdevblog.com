---
title: Update using fl.video package w/ Eclipse and FDT3
author: Phil
layout: post
date: 2008-02-06 00:00:00 +0100
comments: true
permalink: /update-using-flvideo-package-w-eclipse-and-fdt3/
categories:
  - Flash
tags:
  - ActionScript
  - eclipse
  - fdt
  - Flash
  - swc
  - Video
---
Hi &#8230; while building the <a href="http://apdevblog.com/flvplayback-problems-closing-netstream/" title="fullscreen videoplayer" target="_blank">fullscreen-videoplayer</a> I came across the problem, that I was using an old SWC for the fl-package within Eclipse. With the recent Flash Player 9 Update 3 release, Adobe added some real nice features to the FLVPlayback component (e.g. the <a href="http://livedocs.adobe.com/flash/9.0_de/ActionScriptLangRefV3/fl/video/FLVPlayback.html#enterFullScreenDisplayState()" title="enterFullScreenDisplayState()" target="_blank">enterFullScreenDisplayState</a>() method).

To get access to the fl-package within your Eclipse/FDT3-project you have to include another linked SWC (besides the playerglobal.swc). I just created a SWC using the newest fl.video classes. So if you are using FDT3 and are in need of these classes &#8211; just grab them: <a href="/images/2008/02/fl_package.swc" title="FL_PACKAGE.swc" target="_blank">Download the FL_PACKAGE.swc</a>.

cheers 