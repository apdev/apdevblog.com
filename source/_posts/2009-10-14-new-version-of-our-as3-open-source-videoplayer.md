---
title: New version of our AS3 open-source VideoPlayer
author: Phil
layout: post
date: 2009-10-14 00:00:00 +0100
comments: true
permalink: /new-version-of-our-as3-open-source-videoplayer/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - Apdev Videoplayer
  - customize
  - Flash
  - Open Source
  - swfobject
  - Video
  - VideoPlayer
---
Hi there.  
After some inquiries we finally added the possibility to customize the <a href="http://code.google.com/p/apdev-videoplayer/" target="_blank">Apdev VideoPlayer</a> &#8211; only changing colors at this time but it&#8217;s a first step in the right direction &#8230;

<a href="http://apdevblog.com/examples/apdev_videoplayer/html_skinned.html" target="_blank"><img alt="skinned Apdev VideoPlayer" src="http://apdevblog.com/examples/apdev_videoplayer/screenshot_skinned.jpg" title="apdev videoplayer skinned" class="alignnone" width="349" height="290" /></a>

You can now change any color of any object/control that is used within the videoplayer &#8211; but check the <a href="http://apdevblog.com/examples/apdev_videoplayer/docs/com/apdevblog/ui/video/style/ApdevVideoPlayerDefaultStyle.html" target="_blank">ApdevVideoPlayerDefaultStyle.as</a> for all the attributes that can be manipulated. And it&#8217;s up to you whether you change the attributes using pure ActionScript (1) or our html-version of the videoplayer and pass the values in via flashvars (2). With approach 2 you don&#8217;t even have to know ActionScript or open a flash-file &#8211; just embed the videoplayer-swf into your website and customize it via flashvars.  
For further information, see the upcoming examples.

<!--more-->

(1) If you want to use the VideoPlayer in a pure ActionScript project, you can create a new Styles-Object, set all the values you want to change. This object must then be passed into the constructor of the ApdevVideoPlayer and voilà &#8230; you got your own custom player.

Create your own Styles-object

<pre class="brush: as3; title: ; notranslate" title="">package com.apdevblog.examples.style 
{
	import com.apdevblog.ui.video.style.ApdevVideoPlayerDefaultStyle;

	/**
	 * Custom style-sheet for a custom VideoPlayer.
	 */
	public class CustomStyleExample extends ApdevVideoPlayerDefaultStyle 
	{
		/**
		 * constructor.
		 */
		public function CustomStyleExample()
		{
			// player
			bgGradient1 = 0x333333;
			bgGradient2 = 0x000000;
			//
			controlsBgAlpha = 1.0;
			//
			btnGradient1 = 0x333333;
			btnGradient2 = 0x000000;
			btnIcon = 0x66ff00;
			btnRollOverGlowAlpha = 0.2;
			//
			timerUp = 0x66ff00;
			timerDown = 0x999999;
			//
			barBg = 0x333333;
			barBgAlpha = 0.5;
			barLoading = 0x333333;
			barPlaying = 0x66ff00;
			//
			playIcon = 0x000000;
			//
			controlsPaddingLeft = 0;
			controlsPaddingRight = 0;
		}
	}
}
</pre>

Then pass it into the ApdevVideoplayer-constructor:

<pre class="brush: as3; title: ; notranslate" title="">// create own style
var style:CustomStyleExample = new CustomStyleExample();
			
// create videoplayer
var video:ApdevVideoPlayer = new ApdevVideoPlayer(320, 240, style);
			
// position videoplayer on stage
video.x = 25;
video.y = 25;
// add videoplayer to stage
addChild(video);
</pre>

&#8230; and you&#8217;re all done.

(2) Second alternative: You can grab the <a href="http://apdev-videoplayer.googlecode.com/files/apdev-videoplayer-html-example-1.0.2.zip" target="_blank">html-version of our videoplayer</a> from google code and adjust the .html file &#8211; no flash/actionscript needed.

<pre class="brush: xml; title: ; notranslate" title="">// ...

&lt;script type="text/javascript" src="js/swfobject.js"&gt;&lt;/script&gt;
&lt;script type="text/javascript"&gt;
    // &lt;![CDATA[

    var width = 380;
    var height = 240;
    var movie = "htmlvideo.swf";

    // ...

    var flashvars = {};
    
    // video + img info
    flashvars.v = "video01.mp4";
    flashvars.img = "videostill.jpg";
    
    // STYLES
    flashvars.playIcon = "#ff0000";
    flashvars.controlsBg = "#ff00ff";
    flashvars.controlsBgAlpha = 1.0;

    // ...

    swfobject.embedSWF(movie, replaceDiv, width, height, flashVersion, express, flashvars, params, attributes);

  // ]]&gt;
&lt;/script&gt;

// ...
</pre>

Sooo &#8230; there is no reason why you shouldn&#8217;t be already using our VideoPlayer :D  
<a href="http://code.google.com/p/apdev-videoplayer/source/checkout" target="_blank">Check it out</a>.  
Or take a look at the <a href="http://apdevblog.com/examples/apdev_videoplayer/docs/" target="_blank">docs</a> first and then download [the whole package][1].

Enough for now &#8230; but keep the feedback coming, we&#8217;re still eager to improve the player over time.

Cheers. 

 [1]: http://apdev-videoplayer.googlecode.com/files/apdev-videoplayer-1.0.2.zip