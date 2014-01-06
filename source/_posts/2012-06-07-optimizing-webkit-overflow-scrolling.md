---
title: 'Optimizing &#8220;overflow:scroll&#8221; on iOS5 [UPDATE]'
author: Aron
layout: post
date: 2012-06-07 00:00:00 +0100
comments: true
permalink: /optimizing-webkit-overflow-scrolling/
categories:
  - HTML5
  - JavaScript
tags:
  - css
  - HTML5
  - iOS
  - iOS5
  - JavaScript
  - scroll
  - web app
  - webkit
---
{% img /images/2012/06/native-ios-scroll.png "native-ios-scroll" %}

With the never webkit builds on iOS5 and Android ICS finally overflow:scroll works as expected. On iOS you also have the &#8220;native&#8221; scroll bounce, which is huge IMHO (with bounce I mean the ease when the scrolled viewport reaches the top/end). The app finally feels native, a big step for web apps.

<!--more-->

It wasn&#8217;t the sluggishness and weak performance of <a href="http://cubiq.org/iscroll" target="_blank">iScroll</a> and <a href="http://joehewitt.github.com/scrollability/" target="_blank">scrollability</a> I was mad about, it was the wrong implementation of the bounce physics. I was always able the tell the difference of a native and a phonegap app by checking scroll views.

### Get it working

<a href="http://aronwoost.github.com/optimize-webkit-overflow-scrolling/1.html" target="_blank">Check example 1</a> (with iOS5+ device or simulator)

The magic happens with <a href="https://github.com/aronwoost/optimize-webkit-overflow-scrolling/blob/gh-pages/1.html#L23" target="_blank">this line</a>.  
{% gist 2887542 %}

Without you would still have a touchmove scroll with one finger, however the &#8220;native&#8221; bounce comes with -webkit-overflow-scrolling:touch. I notices however one thing that differs from the native scroll. When the content to scroll is on top (e.g. you can&#8217;t scroll any further up) and try it anyways, the touchmove bubbles up. <a href="http://aronwoost.github.com/optimize-webkit-overflow-scrolling/1.html" target="_blank">Try example 1 again</a> (with iOS5+ device or simulator) In this case it bubble to the top window object which then will scroll the browser chrome. While this might be an expected behavior, it still feels not very native. Let&#8217;s fix this. 

### Make it even more native

<a href="http://aronwoost.github.com/optimize-webkit-overflow-scrolling/2.html" target="_blank">Check example 2</a> (with iOS5+ device or simulator) 

When you try the same here, you&#8217;ll notice that you can drag the scrolled content with the expected physics. This feels, well, simply amazing. I have been working with all the JavaScript scroll implementations for such a long time now and now it&#8217;s finally native. Yeah! 

So how is it done?  
{% gist 2887552 %}
  
Well, the magic is to include the scroll content <a href="https://github.com/aronwoost/optimize-webkit-overflow-scrolling/blob/gh-pages/2.html#L57" target="_blank">into another container div</a>, that has to have the <a href="https://github.com/aronwoost/optimize-webkit-overflow-scrolling/blob/gh-pages/2.html#L26" target="_blank">same height as the parent scroll container and also the correct overflow settings set</a> (-webkit-overflow-scrolling doesn&#8217;t seem to be needed). Note that the subcontainer has to have the exact same height, so no margin or padding or stuff allowed. Also note, that no JavaScript is required. This is pure css.

#### Here a video to illustrate the difference between example 1 and 2:

<iframe src="http://www.youtube.com/embed/Yjch40sp4Po" frameborder="0" width="420" height="315"></iframe>


### One last thing

Notice that in the previous example you can still scroll the browser chrome? Try it by dragging (touch moving) the grey background. If you have a web app (instead of a website) you might want to disable the scrolling of the window viewport entirely.

<a href="http://aronwoost.github.com/optimize-webkit-overflow-scrolling/3.html" target="_blank">Check example 3</a> (with iOS5+ device or simulator)

Easy.  
{% gist 2887578 %}
  
<a href="https://github.com/aronwoost/optimize-webkit-overflow-scrolling/blob/gh-pages/3.html#L40" target="_blank">Listen to the touchmove event on document level and prevent the default behavior</a>. With this setting alone scrolling would be disabled globally, also in the overflow div. That why you need to set <a href="https://github.com/aronwoost/optimize-webkit-overflow-scrolling/blob/gh-pages/3.html#L57" target="_blank">another touchmove listener to the scroll div</a> and stop the bubbling. This event then will never reach the document object.

### UPDATE &#8211; Arg, found an edge case

Or, actually not so edge. <a href="http://aronwoost.github.com/optimize-webkit-overflow-scrolling/3a.html" target="_blank">Check a variation of the previous example</a> (with iOS5+ device or simulator) where there are not enough item for the div to be scrollable. When you try to scroll you&#8217;ll notice, that the browser chrome scrolls. Not good.

<a href="http://aronwoost.github.com/optimize-webkit-overflow-scrolling/4.html" target="_blank">Here corrected example 4</a> (with iOS5+ device or simulator)

However, it adds more markup and more JavaScript. I would appreciate a smarter solution. 