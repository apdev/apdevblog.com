---
title: FlashTextFormatter plugin for WordPress
author: Phil
layout: post
date: 2007-11-03 00:00:00 +0100
comments: true
permalink: /flashtextformatter-plugin-for-wordpress/
syntaxhighlighter_encoded:
  - 1
categories:
  - Misc
tags:
  - ActionScript
  - WordPress
---
We&#8217; reusing the <a href="http://flashtexteditor.com/ftf/" title="FlashTextFormatter" target="_blank">FTF wordpress-plugin</a> to view code snippets/samples. It&#8217;s a really nice plugin which automatically colors /highlights your ActionScript (and even more: js, php, python). Just put some [ ftf ] brackets around your code &#8230; the plugin does the rest.

<!--more-->

We&#8217;re actually using this fix from <a href="http://www.zeuslabs.us/2006/06/20/flashtextformatter-with-swfobject-release-2/" title="zeuslab" target="_blank">zeuslab (FTF w/ SWFObject)</a>.

You can also include whole as-files &#8211; but my first attempts all failed. After debugging the script for a while, I found a small bug inside the FlashTextFormatter.php. To fix it you just have to change one line of code:

<pre class="brush: php; title: ; notranslate" title="">// change line 86 from
$ftf_props[$ftf_counter]['file'] = "index.php";

// to sth like this
if(ftf_getProp('file', $ftf_counter) != "")
$ftf_props[$ftf_counter]['file'] = ftf_getProp('file',$ftf_counter);
</pre>

Now everything works fine :) 