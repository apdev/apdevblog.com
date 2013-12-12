---
title: 'ActionScript spell-checking with Squiggly &#8211; AS3 only and Flash 9 compatible'
author: Phil
layout: post
date: 2009-09-24 00:00:00 +0100
comments: true
permalink: /actionscript-spell-checking-with-squiggly-as3-only-and-flash-9-compatible/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - Adobe
  - Flash
  - helper
  - labs
  - library
  - spell-checking
  - spelling
  - Squiggly
  - tool
---
Some days ago Adobe released the spell-checking library called &#8220;<a href="http://labs.adobe.com/technologies/squiggly/" target="_blank">Squiggly</a>&#8220;. According to Adobe the library &#8220;allows you to easily add spell checking functionality in any Flex 3 based text control&#8221; &#8211; but because most of our projects are AS3 only, we decided to build a class which allows you to use the SpellChecker&#8217;s functionality with every normal TextField in Flash.

Unfortunately Adobe messed up the <a href="http://download.macromedia.com/pub/labs/squiggly/squiggly_p1_asdoc_092109.zip" target="_blank">Docs</a> of the library&#8217;s current version (BTW, why do we need to download it? every other doc is accessible online) &#8211; they are talking about Events and EventDispatcher where no Dispatcher can be found and not even one Event is fired. Great that Adobe releases such a tool but they should definitely try to get the facts/info/docs right! Otherwise it&#8217;s really hard for us developers to work with (and maybe improve) the tools they offer.

So here is the first version of our spell-checker for ActionScript 3 / FlashPlayer 9. Currently there is only error-highlighting, the other features will hopefully come within the next few days (suggesting and replacing words).

Try it for yourself &#8230;

<!--more-->

<a href="http://apdevblog.com/examples/apdev_squiggly/" target="_blank"><img class="alignnone" title="apdev Squiggly Example" src="http://apdevblog.com/examples/apdev_squiggly/apdev_squiggly.gif" alt="" width="503" height="302" /></a>

It is as easy as this:

<pre class="brush: as3; title: ; notranslate" title="">import com.apdevblog.text.spelling.ApdevSpellChecker;
// ...

// create + add new TextField
var txt:TextField = new TextField();
addChild(txt);

// create new SpellChecker and set TextField as target
// second parameter is the URL to the dictionary
var url:String = "data/usa.zwl";
var checker:ApdevSpellChecker = new ApdevSpellChecker(txt, url);
</pre>

You can grab version 0.1 of our ApdevSpellChecker class here: <a href="http://apdevblog.com/examples/apdev_squiggly/src/ApdevSpellChecker.as" target="_blank">ApdevSpellChecker.as</a>  
&#8230; and check the example here: <a href="http://apdevblog.com/examples/apdev_squiggly/" target="_blank">http://apdevblog.com/examples/apdev_squiggly/</a>  
More info about Squiggly here: <a href="http://labs.adobe.com/technologies/squiggly/" target="_blank">http://labs.adobe.com/technologies/squiggly/</a>

cheers 