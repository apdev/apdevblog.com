---
title: 'Do not &#8220;learn&#8221; jQuery, learn backbone.js and require.js'
author: Aron
layout: post
date: 2012-07-02 00:00:00 +0100
comments: true
permalink: /learn-backbone-and-require/
categories:
  - HTML5
  - JavaScript
tags:
  - backbone
  - HTML5
  - JavaScript
  - jquery
  - require
---
So you wanna join the little HTML5 party some of us are having? Great! It&#8217;s not that packed yet, quite comfortable actually. And the main gigs haven’t even played yet. So no, you&#8217;re not late. Quite one time actually.

<!--more-->

**Dear JavaScript pros**: This is a blog post for beginners. So don&#8217;t shoot me for simplifying things.

Many developers (especially from the Flash / ActionScript community, but not only them) are currently wanting to &#8220;learn&#8221; HTML5. Some want to focus on websites, others want to build (single-page-) apps. Some want to do shiny advertising&#8217;ish projects, others want to focus more on &#8220;products&#8221;. And many say, that therefore they need to learn jQuery now.

### Do not learn jQuery, just use it!

When someone asks you if you&#8217;re into jQuery, just confirm. Chances are, that clients/employers won’t mind to ask, since they assume that you do.

My prediction is, that you&#8217;ll use 10 jQuery methods max in the beginning. When starting with jQuery, using jQuery is mostly understanding HTML and CSS (you understand HTML and CSS, right?). Anyway, <a href="http://api.jquery.com/" target="_blank">api.jquery.com</a> is your friend. In a year from now, you&#8217;ll probably laugh about your jQuery code, but that&#8217;s ok for now, you have bigger problems.

### How to produce clean code in JavaScript

The more important question is, how to build clean, manageable, understandable and maintainable JavaScript code. And unlike two years ago there are two industry standards now: <a href="http://documentcloud.github.com/backbone/" target="_blank">backbone.js</a> and <a href="http://requirejs.org/" target="_blank">require.js</a>.

Backbone enables you to write a class-like code structure, that fulfills all the aforementioned criteria. And &#8211; most importantly &#8211; since it so widespread many people already know it. For me, working with backbone made working in big teams possible (you want to work in big teams, right?). There are many other frameworks out there, lots of them with a strong feature set. However, what I like about Backbone that it *does not* have a big feature set. 

Require on the other side, not only encourages you to write loosely coupled and granular parts of code but also helps you to structure *the JS files* that hold your code. It makes you create JavaScript modules in a standardized way, so that you can easily plug them together. I know first hand, how hard it is in the beginning to decide how to organize the JavaScript files/folders and how to get them into the application. Require.js is there for exactly that.

### So how to learn them then?

While understanding require is quite straight forward (the documentation will do), the learning curve of backbone is harder. Try to avoid the famous <a href="http://backbonejs.org/examples/todos/index.html" target="_blank">ToDo list example</a>. It gives the impression that backbone applications are always big and/or complicated. The truth is backbone can be extremely simple. Start with something <a href="http://thomasdavis.github.com/2011/02/01/backbone-introduction.html" target="_blank">waaaaay simpler</a>.

Unlike other coding communities, the JavaScript community is almost entirely based on open source. It basically lives on <a href="https://github.com/" target="_blank">github</a>. This includes <a href="https://github.com/documentcloud/backbone" target="_blank">backbone</a> and <a href="https://github.com/jrburke/requirejs" target="_blank">require</a>. So if you don&#8217;t already have a github account &#8211; go and get one. And hang out there for a while. 

Other things you might want to check on github:  
* <a href="https://github.com/h5bp/html5-boilerplate" target="_blank">HTML5 Boilerplate</a> (especially the <a href="https://github.com/h5bp/html5-boilerplate/blob/master/.htaccess" target="_blank">.htaccess file</a> is very interesting)  
* <a href="https://github.com/twitter/bootstrap/issues" target="_blank">Twitter Bootstrap issues</a>  
* <a href="https://github.com/Modernizr/Modernizr" target="_blank">Modernizr</a>  
* <a href="https://github.com/darcyclarke/Front-end-Developer-Interview-Questions" target="_blank">Good list of things to look into</a> 