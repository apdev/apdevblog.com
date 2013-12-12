---
title: ActionScript Spellchecker for Flash Textfields (with source code and example)
author: Phil
layout: post
date: 2009-10-21 00:00:00 +0100
comments: true
permalink: /actionscript-spellchecker-for-flash-textfields-with-source-code-and-example/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - error-highlighting
  - Flash
  - Open Source
  - spell
  - spell-checking
  - spelling
  - Squiggly
  - Text
  - textfield
---
Finally I had the time to add the missing features to our <a href="http://apdevblog.com/actionscript-spell-checking-with-squiggly-as3-only-and-flash-9-compatible/" target="_blank">Spellchecker class v01</a>.  
You can now right-click the misspelled words and get suggestions from the loaded dictionary in the context-menu.

<a href="http://apdevblog.com/examples/apdev_spellchecker/" target="_blank"><img src="/images/2009/10/apdev_spellchecker.gif" alt="apdev spellchecker" title="apdev spellchecker" width="500" height="270" class="alignnone size-full wp-image-691" /></a>

<!--more-->

Version 2 also improves the performance when checking really long textfields because we only check the visible part of the text. So as long as your textfield doesn&#8217;t have 3000 visible lines of text, it&#8217;ll work just fine.

So again, this is ActionScript-only spellchecking for FlashPlayer 9. No Flex required (compared to Adobe&#8217;s version).

The Apdev Spellchecker is built on top of Adobe&#8217;s &#8220;<a href="http://labs.adobe.com/technologies/squiggly/" target="_blank">Squiggly</a>&#8220;, which they released earlier.

Get our class here: <a href="http://apdevblog.com/examples/apdev_spellchecker/src/ApdevSpellChecker.as" target="_blank">ApdevSpellChecker.as</a>  
And the required classes from Adobe here: <a href="http://labs.adobe.com/downloads/squiggly.html" target="_blank">http://labs.adobe.com/downloads/squiggly.html</a>

\*Small update\* Example for TextField in Flash CS4:  
[apdev-spellchecker-example-cs4.zip][1]

Hope this helps anybody &#8230;

Cheers 

 [1]: http://apdevblog.com/examples/apdev_spellchecker/apdev-spellchecker-example-cs4.zip