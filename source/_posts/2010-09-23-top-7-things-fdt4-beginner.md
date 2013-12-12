---
title: 7 things to do first when starting with FDT4
author: Aron
layout: post
date: 2010-09-23 00:00:00 +0100
comments: true
permalink: /top-7-things-fdt4-beginner/
categories:
  - Misc
tags:
  - ActionScript editor
  - code editor
  - fdt
  - FDT4
---
Recently I upgraded to FDT4. Well, not exactly upgraded since I downloaded a fresh Eclipse version (for using FDT as plug-in) and created a new workspace. Here 7 things essential for me to start working with FDT4.

<!--more-->

**Note:** Some of the points will maybe auto set, when using the final FDT4 Standalone version.

### 1. Always launch previous application

When hitting F11 by default Eclipse is launching the currently active class (the one you&#8217;re currently editing). Of course you want to launch the previous build. Got to Preferences -> Run/Debug -> Launching and set the &#8220;Launch Operation&#8221; to &#8220;Always launch the previous launched application&#8221;.

![][1]

### 2. Disable Autobuild

When working with big project FDT4 has a hell of work to do when (re-)building the project. This can be seriously annoying. So instead of letting FDT autobuild the project when changes happen, you want to do this manually (ctrl/cmd + B). Goto Project and disable &#8220;Build automatically&#8221;.

![][2]

### 3. Set class comment header

With that you not only have your copyright in the class (not so useful) but also will the svn tag be updated. Go to Preferences -> FDT -> Code Style -> Code Templates -> &#8220;typecomment&#8221; -> &#8220;Edit&#8230;&#8221; and insert your custom class comment.

![][3]

### 4. Set the braces correctly

It drives me nuts, when the braces formating style is not correct ;). Go to Preferences -> FDT -> Code Style -> ActionScript Formatter -> Braces Tab -> &#8220;Wrap All&#8221;. Clean that mess with ctrl/cmd + shift + F.

![][4]

### 5. Make the code assist work more responsive

You want to code assistant to appear when typing and not only when typing . or hitting ctrl/cmd + SPACE. Go to Preferences -> FDT -> Editor -> Code Assist. Set the delay in the &#8220;Auto activation Delay:&#8221; to 50. In the field &#8220;Auto activation triggers for AS:&#8221; you insert &#8220;abcdefghijklmnopqrstuvwxyz_.:&#8221;.

![][5]

### 6. Show line numbers

You need then, don&#8217;t you? Right click on the grey vertical bar, left to the code editing window and select &#8220;Show line numbers&#8221;.

![][6]

### 7. View classes hierachical in the Flash Explorer

No need to share the space with all classes.

![][7]

### Wait! Are there more?

So these are my 7 steps to get FDT4 up and running. Take it or leave it&#8230; :)

Do you have some FDT essentials you can&#8217;t live without? **Please write a comment!** 

 [1]: /images/img/top-7-fdt/top-01.gif
 [2]: /images/img/top-7-fdt/top-02.gif
 [3]: /images/img/top-7-fdt/top-03.gif
 [4]: /images/img/top-7-fdt/top-04.gif
 [5]: /images/img/top-7-fdt/top-05.gif
 [6]: /images/img/top-7-fdt/top-06.gif
 [7]: /images/img/top-7-fdt/top-07.gif