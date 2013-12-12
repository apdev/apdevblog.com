---
title: 'FLVPlayback &#8211; problems closing NetStream'
author: Phil
layout: post
date: 2008-02-04 00:00:00 +0100
comments: true
permalink: /flvplayback-problems-closing-netstream/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - Flash
  - Video
---
Today I tried to create a fullscreen-videoplayer using Flash CS3&#8242;s own FLVPlayback class. Everything worked fine &#8230; untill I tried to remove the videoplayer from stage while it was still loading the flv-videofile. The player wouldn&#8217;t stop streaming the file, it just kept on playing the video &#8211; even after i had removed it. I googled in hope to find an easy solution to this problem and found this <a href="http://www.cnblogs.com/bluekylin/archive/2006/07/21/456750.html" title="Bluekylin" target="_blank">post by Bluekylin</a>.

<!--more-->

So I tried this line:

<pre class="brush: as3; title: ; notranslate" title="">// get the current VideoPlayer and close the NetStream
getVideoPlayer(activeVideoPlayerIndex).close();
</pre>

&#8230; and it really worked :)  
The getVideoPlayer() method return a VideoPlayer object which offers you the opportunity to close the NetStream via close().  
This line really solved the problem and stopped the file from being streamed/loaded.

Maybe this is of some help to you &#8230; cheers 