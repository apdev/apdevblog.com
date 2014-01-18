---
title: Super simple Flash example of the Indexhibit frontend
author: Phil
layout: post
date: 2009-10-23 00:00:00 +0100
comments: true
permalink: /super-simple-flash-example-of-the-indexhibit-frontend/
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
  - frontend
  - indexhibit
  - swfobject
---
Finally we finished the &#8220;super simple&#8221; Flash example of our frontend for <a href="http://indexhibit.org" target="_blank">Indexhibit</a>.  
You can read more about the whole Flash / Indexhibit story <a href="/flash-frontend-for-indexhibit-cms/" target="_blank">here</a>, <a href="/sources-for-flash-frontend-for-indexhibit-cms/" target="_blank">here</a> and <a href="/installation-guide-for-flash-indexhibit-frontend/" target="_blank">here</a> or just grab the [new files][1] and try for yourself &#8230;

<a href="/examples/indexhibit_simple/" target="_blank"><img src="/images/2009/10/simple_indexhibit_example.jpg" alt="simple indexhibit example" title="simple indexhibit example" width="500" height="313" class="alignnone size-full wp-image-708" /></a>

<!--more-->

The previous sources/example was ActionScript-only and had to be compiled using the Flex compiler &#8211; this one comes as a FLA-file with a few classes to back it up. But only two of those classes are really of any interest to you if you want to customize the whole thing visually.

[SimpleExample.as][2] (document-class set via properties panel in flash)  
[Exhibit.as][3] (this one is linked to the exhibit movieclip in the library)

We tried to keep the example as basic as possible so there is no real &#8220;animation-mania&#8221; or something going on &#8211; some timeline tweenings, that&#8217;s all.

If you&#8217;re interested in building your own flash frontend for Indexhibit, just open the FLA-file and start from there &#8230; if you then still have any questions, don&#8217;t hesitate and leave us a comment.

Grab the sources here: [/examples/indexhibit\_simple/src/apdev\_ndxz_simple.zip][1]  
Or take another look at the example: <a href="/examples/indexhibit_simple/" target="_blank">/examples/indexhibit_simple/</a>

If you want to use your own Indexhibit installation and build a flash-frontend on top of that, you have to download the [amf-package][4] and put it in the root-directory of your webserver. change the dbaccess.php in the amf/includes folder to your database-name and -login &#8230; et voilà the remoting gateway should be running smoothly. The next thing you have to change is the SERVER_URL in the SimpleExample-class in Flash &#8211; it should be your server&#8217;s name not ours ;)

That&#8217;s it for now &#8230; cheers 

 [1]: /examples/indexhibit_simple/src/apdev_ndxz_simple.zip
 [2]: /examples/indexhibit_simple/src/SimpleExample.as
 [3]: /examples/indexhibit_simple/src/Exhibit.as
 [4]: /examples/indexhibit_simple/src/apdev_indexhibit_amf.zip