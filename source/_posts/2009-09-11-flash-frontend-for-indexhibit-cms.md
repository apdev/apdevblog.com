---
title: Flash frontend for Indexhibit CMS
author: Phil
layout: post
date: 2009-09-11 00:00:00 +0100
comments: true
permalink: /flash-frontend-for-indexhibit-cms/
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
  - Graceful Degradation
  - html
  - indexhibit
  - SEO
  - swfaddress
  - swffit
  - swfobject
---
Hi there.  
After working with different content management systems over the last few years &#8211; like Typo3, Joomla and even some custom made ones &#8211; I came across a very neat one called <a href="http://www.indexhibit.org/" target="_blank">Indexhibit</a>. It&#8217;s not like you can compare Typo3 to Indexhibit &#8211; except maybe that they both are called CMS &#8211; but many projects we did in the past required only a small kind of management system. And that is exactly what Indexhibit has to offer. It&#8217;s an easy-to-use CMS with the most common features: create categories, add projects to category, edit headline/copy, upload images, etc.

<a href="/indexhibit/" target="_blank"><img class="alignnone size-full wp-image-401" title="apdev indexhibit" src="/images/2009/09/aphibit_small.jpg" alt="apdev indexhibit" width="500" height="319" /></a>

<!--more-->

So in the end I looked at the underlying database-structure of Indexhibit and decided to write a small PHP-script to access the data via Flash Remoting, allowing me to build a flash frontend &#8220;on top&#8221; of the normal HTML website. It wasn&#8217;t any rocket science but as I couldn&#8217;t find anything via Google I decided to give it a go &#8230; and of course share it with you :)

Here&#8217;s the link to the <a href="/indexhibit/" target="_blank">example page</a> I put together just for showing you how one could take the data Indexhibit offers and create a totally different page from the corresponding <a href="/indexhibit/ndxz/" target="_blank">HTML one</a>.

Using <a href="http://code.google.com/p/swfobject/" target="_blank">SWFObject</a> and <a href="http://www.asual.com/swfaddress/" target="_blank">SWFAddress</a> I also implemented deeplinks for all projects on the flashpage.

Deeplink example for &#8220;Project Internet 03&#8243;:  
<a href="/indexhibit/#/websites/internet-03/" target="_blank">/indexhibit/#/websites/internet-03/</a>

Another bonus using SWFAddress is that the visitor can navigate the page using the browser&#8217;s own back/forward buttons.

Having both a HTML and a flash page is great because you can offer content for all users browsing the web (pc/mac with or without flashplugin, iPhone (no flash), &#8230;). And because Indexhibit is very good when it comes to <a href="http://en.wikipedia.org/wiki/Search_engine_optimization" target="_blank">Search engine optimization (SEO)</a> your content will be found by Google & co. Normal flashpages&#8217; content cannot be crawled by bots &#8211; so again this is a great plus.

The example even degrades gracefully &#8211; when you open the flashpage (or any of its deeplinks) and you don&#8217;t have the flashplayer installed, you get forwarded to the corresponding HTML page. If you open <a href="/indexhibit/#/websites/internet-03/" target="_blank">/indexhibit/#/websites/internet-03/</a> (flash) without any flashplayer installed you are automatically led to <a href="/indexhibit/ndxz/websites/internet-03/" target="_blank">/indexhibit/ndxz/websites/internet-03/</a> (html).

&#8216;Nuff said for now. I still have to clean up the code &#8211; so no sources right now. But I&#8217;ll definitely post them during the next days/week.

\*\\*\* edit \*\**  
you can find the sources here: </sources-for-flash-frontend-for-indexhibit-cms/>

or view all blog posts concerning our flash/indexhibit frontend:  
</tag/indexhibit/>

Cheers. 