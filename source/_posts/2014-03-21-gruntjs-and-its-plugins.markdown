---
layout: post
title: "gruntjs and its plugins"
date: 2014-03-21 11:00:00 +0100
author: phil
comments: true
categories: 
  - web development
tags:
  - JavaScript
  - task runner
  - gruntjs
  - gulpjs
---
... or even more suitable: "plugin mess". But I'll start the story at the
beginning.

I wanted to take look at [Grunt][1] for a while now. Finally, a couple of weeks
ago, I ran into a problem that I couldn't overcome with [NPM][2] and its `scripts`
section alone. The right time to check out Grunt, I thought. Has been too long
on my TODO-list.

The problem I had to handle was: deployment of a node project to my dev server.
And I didn't want to rely on git hooks or CI for this. I wanted a script I
could call that uploaded everything to my dev server via ssh, ran `npm install`
and restarted the application (more on this in a seperate post later).

After googling for "deploy grunt" and reading through the gazillion results, it
became quickly clear to me, that I wasn't the first person that wanted to try
and do this with the help of the boar (or whatever [this thing][8] is).
I installed about every grunt plugin I could find but none fit my needs exactly
... so what now? Fork another plugin and adjust it to comply with my
requirements? Write my own plugin from scratch?  

No, no, no. I might want to reuse this later on with a different server (no ssh)
or deploy a frontend-project (not a node one) and would have to update/extend
the plugin to accomodate this. Most authors of the aforementioned plugins have
done exactly that - they wrote a plugin that did what they needed 100%. But
because we as developers are very biased and only want to do it "our way", these
plugins are all the same but at the same time different. And, of course, I didn't
like a single one of them :).

Ok, so no plugin. What then. I decided to write a simple Grunt task that used
other node modules (not Grunt plugins) to accomplish everything I needed. In
this, I could reuse code that others had written - maybe not for this use-case
but as a standalone module that was so granular that it "only" solved _one_
problem but that perfectly.

**Don' write plugins that try to solve too many problems at once.**

Write small modules that run in all kind of environments and solve exactly one
problem. This way, others can use your code - even in scenarios which you
haven't been thinking about while writing the code ... this is a good thing.

Funny enough, a couple of days after my first stint with Grunt, I listened to
the [JavaScript Jabber podcast][3] and they were talking about [Gulp][4] (and
Grunt, of course) with [Eric Schoffstall][7] - one of the developers behind "the
streaming build system".
It was really interesting and you should definitely go and listen to it (after
you've finished reading the post).

I don't want to talk about performance or other important reasons why A is
better than B, but there are two things - in my eyes - Gulp (or the Gulp
community) does better than Grunt:

1) There is a curated [plugin list][5]

{% blockquote Eric Schoffstall, episode 97 of The JavaScript Jabber %}
So, we’re curating it. We don’t just come out and say, “Oh this plugin sucks. We think it’s stupid. You’re not allowed on our website.” But we do say, “This plugin doesn’t work,” or, “It has too many bugs. It just shouldn’t be a plugin. And those are our requirements.”
{% endblockquote %}

So there shouldn't be duplicate plugins or plugins that wrap some functionality
you could use directly via its node module

2) [Recipes][6] instead of too many plugins

{% blockquote Eric Schoffstall, episode 97 of The JavaScript Jabber %}
[...] we actually have a section of docs called recipes. And these are just, “Hey, I used Mocha with Gulp. Here is a task that I used it in and let me explain why I did a couple of things.” So that way, people can just say, “Okay, I want to use Mocha. Let me go look at the recipes and go find one for Mocha.” And it’ll explain in-depth why they did what they did, how to use it [...]
{% endblockquote %}

If there is a problem you solved by using already available node modules, share
it with other devs that might get stuck at the same point. But don't do it
writing your own plugin - write a small HOWTO instead.

**Don't write code that can't be used outside of Grunt/Gulp**

Cheers.


[1]: http://gruntjs.com/
[2]: https://www.npmjs.org/
[3]: http://javascriptjabber.com/097-jsj-gulp-js-with-eric-schoffstall/
[4]: http://gulpjs.com/
[5]: http://gulpjs.com/plugins/
[6]: https://github.com/gulpjs/gulp/tree/master/docs/recipes
[7]: https://twitter.com/eschoff
[8]: http://gruntjs.com/img/grunt-logo.png