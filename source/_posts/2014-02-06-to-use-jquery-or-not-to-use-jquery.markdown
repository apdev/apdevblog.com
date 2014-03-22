---
layout: post
title: "To use jQuery or not to use jQuery, that is the question"
date: 2014-02-07 11:00:00 +0100
author: Phil
comments: true
categories: 
  - performance
  - web development
  - post
tags:
  - JavaScript
  - performance
  - library
  - framework
  - jQuery
---
There was a lot of buzz around [YOU MIGHT NOT NEED JQUERY][1] the last couple 
of days - we also mentioned it in our [weekly digest #2][2] from last monday.

YMNNJ is a collection of vanilla JavaScript snippets that can (more or less) 
replace some often used jQuery built-in functions. [Zack Bloom][3] and
[Adam Schwartz][4], the guys behind YMNNJ, want us to think twice before using a
(big) framework/library like jQuery:

> If you're developing a library on the other hand, please take a moment to consider if you actually need jQuery as a dependency. Maybe you can include a few lines of utility code, and forgo the requirement.

I totally agree with this statement. You should pause and ponder before using 
something like jQuery (or e.g. Modernizr), be it in a library or any other project you are doing. It comes with a cost that you definitely should be aware of.

[Tim Kadlec][5] also wrote a [post][6] and sums up the performance hits pretty well:

> This is concerning, but it’s not just download sizes that you should be worried about. In a presentation given at Velocity in 2011, Maximiliano Firtman pointed out that on some phones (older, but still popular, BlackBerry devices for example) can take up to 8 seconds just to parse jQuery. More recent research from Stoyan Stefanov revealed that even on iOS 5.1, it was taking as many as 200-300ms to parse jQuery.

But jQuery isn't all bad, of course not. Fittingly, [Webplatform Daily][7] posted
a link to a [list][8] by [Rick Waldron][9] of all the quirks jQuery fixes for us developers that need to address as much devices/browsers as possible. Try fixing (or even finding them in the first place) them in vanilla JS by yourself.

So, if you're aware of the "downsides" of something like jQuery but decide to use
it anyway (because of all the "upsides" it includes), it's totally fine. But think
of ways to use it responsibly.

Again taken from Mr. Kadlec's post:

> [...] some of the devices we needed to test on couldn’t load the page at all if jQuery was present — it was just too much JavaScript for the device to handle.

In one of our last mobile projects we decided to rely on jQuery for all the more
fancy things we wanted to implement. Features that the older phones couldn't or 
shouldn't cope with because they would crash or suffer devastating performance 
hits that would keep the users from navigating the site. Using
[Progressive enhancement][10] and a technique like the BBC's 
["Cutting the mustard"][10] allowed us to only deliver JavaScript (including 
jQuery) to the more capable devices - avoiding to make your beloved 
Blackberry explode :)  
In addition, the user only had to download HTML, CSS and assets to view the
page, which saved about 40-50KB of transfered data and some JS parsing/execution
time.

Tim's closing paragraph:

> I’m not saying that we stop using libraries altogether—and neither were the people who created “You Might Not Need jQuery”. I’m suggesting we make that decision with a great deal of care.

WORD!


  [1]: http://youmightnotneedjquery.com/
  [2]: http://apdevblog.com/weekly-digest-2/
  [3]: https://twitter.com/zackbloom
  [4]: https://twitter.com/adamfschwartz
  [5]: https://twitter.com/tkadlec/
  [6]: http://timkadlec.com/2014/01/smart-defaults-on-libraries-and-frameworks/
  [7]: http://webplatformdaily.org/
  [8]: https://gist.github.com/rwaldron/8720084#file-reasons-md
  [9]: https://twitter.com/rwaldron/
  [10]: http://alistapart.com/article/understandingprogressiveenhancement
  [11]: http://responsivenews.co.uk/post/18948466399/cutting-the-mustard