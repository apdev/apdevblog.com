---
title: 'Sources for &#8220;Flash frontend for Indexhibit CMS&#8221;'
author: Phil
layout: post
date: 2009-09-18 00:00:00 +0100
comments: true
permalink: /sources-for-flash-frontend-for-indexhibit-cms/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - AMF
  - AMFPHP
  - cms
  - Flash
  - Flash Remoting
  - indexhibit
  - swfaddress
  - swffit
  - swfobject
---
Last week I wrote (see <a href="/flash-frontend-for-indexhibit-cms/" target="_blank">Flash frontend for Indexhibit CMS</a>) about our <a href="/indexhibit/" target="_blank">flash-indexhibit-example</a>.  
Today I also uploaded the [sources][1] &#8230;  
I cleaned up the code but didn&#8217;t have the time to write any detailed comments. So take a look at the source-code and if you should have any questions, just leave a comment and we&#8217;ll try and help you as fast as we can.

The startpoint into the example is the <a href="/examples/indexhibit/src/classes/com/apdevblog/examples/indexhibit/Index.as" target="_blank">Index</a> class. This is only a loader-class responsible for loading the <a href="/examples/indexhibit/src/classes/com/apdevblog/examples/indexhibit/Main.as" target="_blank">Main</a> class which initializes the <a href="http://trac.puremvc.org/PureMVC_AS3/" target="_blank">pureMVC framework</a> and starts the application. After that, we use the <a href="/examples/indexhibit/src/classes/com/apdevblog/examples/indexhibit/controller/app/StartupCommand.as" target="_blank">StartupCommand</a> to setup the application&#8217;s <a href="/examples/indexhibit/src/classes/com/apdevblog/examples/indexhibit/model/IndexhibitProxy.as" target="_blank">model</a> and access the Indexhibit database via our <a href="/examples/indexhibit/src/classes/com/apdevblog/amf/RemoteGateway.as" target="_blank">RemoteGateway</a> and the server-side remoting service &#8220;<a href="/examples/indexhibit/bin/amf/services/com/apdevblog/examples/indexhibit/Indexhibit.txt" target="_blank">Indexhibit</a>&#8220;.

To make the data handling easier we have two kinds of <a href="http://en.wikipedia.org/wiki/Data_transfer_object" target="_blank">value objects</a>: <a href="/examples/indexhibit/bin/amf/services/com/apdevblog/examples/indexhibit/model/vo/ExhibitVo.txt" target="_blank">ExhibitVo</a> and <a href="/examples/indexhibit/bin/amf/services/com/apdevblog/examples/indexhibit/model/vo/ImageVo.txt" target="_blank">ImageVo</a>. The remote-service is delivering you an array of ExhibitVos which you can use to display every available project from your Indexhibit installation.

If you want to dive right into the code, we recommend that you have at least a basic knowledge of the pureMVC framework&#8217;s design and functionality. Otherwise it&#8217;ll be hard to understand how the example is structured/built.

Other scripts we used in this example:

*   <a href="http://code.google.com/p/swfobject/" target="_blank">SWFObject</a>
*   <a href="http://www.asual.com/swfaddress/" target="_blank">SWFAddress</a>
*   <a href="http://swffit.millermedeiros.com/" target="_blank">SWFFit</a>
*   <a href="http://www.spicefactory.org/" target="_blank">spicefactory</a>
*   <a href="http://www.amfphp.org/" target="_blank">AMFPHP</a>
*   <a href="http://blog.greensock.com/tweenliteas3/" target="_blank">TweenLite</a>
*   <a href="http://www.quasimondo.com/archives/000565.php" target="_blank">Quasimondo&#8217;s ColorMatrix</a>
*   and of course <a href="http://www.indexhibit.org/" target="_blank">Indexhibit</a>

Get the sources here: </examples/indexhibit/apdev_indexhibit.zip>

Cheers

ps: we&#8217;ll be heading to brighton tomorrow, so you&#8217;ll have to wait for a replay at least until thursday next week.  
<a href="http://www.flashonthebeach.com/" target="_blank">FOTB</a> here we come :)  
and watch out for our detailed report after we&#8217;re back from the beach. 

 [1]: /examples/indexhibit/apdev_indexhibit.zip