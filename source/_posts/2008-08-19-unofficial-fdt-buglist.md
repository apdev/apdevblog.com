---
title: Unofficial FDT Buglist
author: Aron
layout: post
date: 2008-08-19 00:00:00 +0100
comments: true
permalink: /unofficial-fdt-buglist/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - eclipse
  - fdt
  - Flash
---
**UPDATE: There is a [official buglist now][1]. Please read [this post][2].**

We are working with <a href="http://fdt.powerflasher.com/" target="_blank">FDT</a> since version 1.5 and think that it is by far the best ActionScript tool out there; we tried [FlashDevelop][3], <a href="http://www.sephiroth.it/python/sepy.php" target="_blank">Sepi</a> and all the others. Most of the people we work with are using FDT and most of them are pretty pleased, though some of them are a bit shocked when they see the <a href="http://fdt.powerflasher.com/products/fdt-3/enterprise/" target="_blank">price tag</a>&#8230;

However we have the feeling that since the release of <a href="http://fdt.powerflasher.com/blog/?p=45" target="_blank">FDT 3.0 Enterprise</a> the development stocked somehow. In our daily work we found a lot of small and big bugs, more or less annoying. Some of them are so obvious and we are wondering why they don&#8217;t get fixed. The <a href="http://fdt.powerflasher.com/forum/" target="_blank">Bug section of their forum</a> is sadly not usable for &#8220;real bugs&#8221; since its full of posts like &#8220;Help me, my FTD is not working&#8221;.

So we decided to publish our own unofficial buglist. Of course, we sent them to the FDT team too and when a bug is fixed we&#8217;ll update the list asap.

<!--more-->

So here we go:

<table style="border-width: thin thin thin thin;border-spacing: 0px;border-style: none none none none;border-collapse:collapse;border-color: #666666; margin-bottom:40px;" border="1" cellspacing="0" cellpadding="2">
  <tr>
    <th>
      bug description
    </th>
    
    <th width="75">
      fixed
    </th>
  </tr>
  
  <tr>
    <td>
      &#8220;Organize imports&#8221; inserts the import statements sometimes below the sourcecode (or somewhere else at the wrong position). When pressing control-o the second time the imports are most of the time organized correctly. This especially happens when working with external core libarys like the <a href="/update-using-flvideo-package-w-eclipse-and-fdt3/" target="_blank">fl-core</a>. Not 100% reproducible.
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      When the addEventListener method is passed more than the required parameter, the quickfix to create the listener method is not working anymore.<br /> <a title="addEventListener bug image 1" rel="lightbox" href="/images/2008/08/fdt_bug_01.jpg"><img src="/images/2008/08/fdt_bug_01_small.jpg" alt="as3 tour" align="left" /></a><a title="addEventListener bug image 1" rel="lightbox" href="/images/2008/08/fdt_bug_02.jpg"><img src="/images/2008/08/fdt_bug_02_small.jpg" alt="as3 tour" align="left" /></a>
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      If there is an error in (for instance) line 13 and you insert something in the lines above, the auto completion is not working anymore. Not always reproducible, though happens a lot at daily work.
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      In general: When working with FTD for several hours, it tends to get slow and sometimes at some point even basic functionality (like auto completion) stops working. Only restart helps.
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      If you want to refresh a swc: Click on the swc -> press F5 -> FDT freezes. You have to cancel the operation by clicking &#8220;cancel&#8221;. Then sometimes wrong classes are displayed (some are duplicate). Only restart helps.
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      When you pass an anonymus object to a method (like HydroTween.go) and this object has more than one property, the code hint is wrong.<br /> <a title="object parameter bug" rel="lightbox" href="/images/2008/08/fdt_bug_03.jpg"><img src="/images/2008/08/fdt_bug_03_small.jpg" alt="as3 tour" align="left" /></a>
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      When typing ++ticker -> control-1 -> the property created in the header becomes a Boolean.<br /> <a title="type bug" rel="lightbox" href="/images/2008/08/fdt_bug_04.jpg"><img src="/images/2008/08/fdt_bug_04_small.jpg" alt="as3 tour" align="left" /></a>
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      When you press control-shift-o (organize imports) during the workspace build process nothing is happening. A &#8220;please wait&#8221; alert box should apear.
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      You can access a protected get method outside of the class without getting a live error. Later the compiler is complaining.
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      If you move packages (refacoring) the package paths are not updated correctly.
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      Object.toString() and Array.toString() is missing for auto completion.<br /> <a title="missing auto completion method mapping " rel="lightbox" href="/images/2008/08/fdt_bug_05.jpg"><img src="/images/2008/08/fdt_bug_05_small.jpg" alt="as3 tour" align="left" /></a>
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      Happens all the time when using auto completion (still not 100% reproducible): control-space -> select parameter of method with the coursor -> hit ENTER -> the windows jumps up (to line one or something like that).
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
  
  <tr>
    <td>
      In case there are duplicated classes in the classpath (for instance inside the &#8220;real&#8221; classpath and inside an asset swc) the in &#8220;FDT Source Folder&#8221; selected order is correctly used for compiling, but not for auto completion, code hinting and live error highlight.
    </td>
    
    <td align="center">
      <span style="color: #ff0000;">no</span>
    </td>
  </tr>
</table>

If you have any suggestions (or find mistakes in the list) please leave a comment. Or maybe you found a reproducible &#8220;every-day&#8221; bug you want us to add to the list.

**Please do not post general FDT questions.**

For FDT support please contact the <a href="http://fdt.powerflasher.com/products/fdt-3/support/" target="_blank">FDT support team</a> or leave a thread in to <a href="http://fdt.powerflasher.com/forum/" target="_blank">FDT forums</a>. 

 [1]: http://bugs.powerflasher.com/
 [2]: /fdt-buglist-they-heard-us/
 [3]: http://www.flashdevelop.org/community/