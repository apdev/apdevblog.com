---
layout: post
title: "Mobile performance and how it suffers from 3rd party content"
date: 2014-01-30 11:00:00 +0100
author: Phil
comments: true
permalink: /mobile-performance-and-how-it-suffers-from-3rd-party-content
categories:
  - performance
  - mobile
  - web development
tags:
  - JavaScript
  - browser
  - performance
  - mobile
---
Nowadays, when you talk to a web developer about building a (mobile) website,
performance is one of the topics that comes up quickly. This is absolutely great
and we have to say 'thank you' to a bunch of [people][1] [never][2]
[stopping][3] [to][4] [bother][5] [us][6] with these things.

So we developers take care of:

- gzipping
- minify/uglify + concat HTML, JS and CSS
- all blocking JS at the bottom of the page
- caching/CDN
- fewer requests
- and a lot more ...

Each of the points above will improve your site's performance - sometimes more
sometimes less, depending - of course - on your site and its structure/content.

In one of our last projects we took this to heart and wanted to deliver a
beautiful and fast mobile website (m-dot-domain, so it was really only mobile).
We're not talking about the "under 1 second to screen" scenario, but rather a
smooth surfing experience using a 3G network. Let's say something like 1-2
seconds until "start to render" and ~10 seconds for "loaded".

Starting with HTML templates/components that - if needed - get progressively 
enhanced was a good foundation for this. With dummy content filling the HTML, 
this is a breakdown of the filesizes (gzipped) by type:

- HTML ~15KB
- CSS ~15KB
- JS ~50KB (biggest part being jQuery)
- images ~500KB
- fonts ~45KB

Putting JS at the bottom of the `<body>` made the browser only wait for the HTML
and CSS before beginning to render the page. Sadly, because we're using
webfonts, it begins rendering the content without displaying the text. Only 
after the webfont is downloaded, does the text become visible - in my eyes
webfonts' *biggest* disadvantage.

[{% img /images/2014/01/waterfall-templates-complete.png 462 513 'waterfall for our templates' %}][11]

*I used my slow vServer to get this waterfall, so an optimized setup with an 
additional CDN (like the live-server) should be even faster.*

As we can see in the waterfall above - "start render" lies somewhere between 2-3 
seconds and the webfonts are loaded a second later. This way the user should be
able to start reading after 4 seconds. So far, so good.

This is also the moment the JS is loaded (async) and executes. Some of the
components "change" a bit because of the progressive enhancement kicking in but
nothing so serious that it'll annoy the user too much.  
And this is only for the user's first visit - the second time the cache will be
filled with our CSS, JS, images and fonts and the page load time should be even
faster.

Because our client uses a big fancy CMS, this is the point where we bundled up
our assets and handed them over to them. Their developers had to integrate our
templates and scripts into the colossus that is their CMS *and* most of all, 
they also had to add things like:

1. tracking and
2. advertising
3. real content

From here on out it got messy ...

Tracking shouldn't have been a big problem, you might think. No, it usually isn't. 
But they had to include more than one tracking-script and not at the bottom of 
the document but the head (I think we could check and move them to the bottom, 
though). These are mostly small scripts that load fast but every request hurts
on mobile.  
There are services like [Segment.io][7] but they are US-based
and we Germans don't like to send our data across the pond ;) Besides, I don't
think they support german newspapers' most important tracking-provider IVW.  
Nonetheless are these kind of services a great tool for improving your website's
performance: one call instead of two or three every time you want to track
something = big win!

On to advertisement. Because our client offers all its content free of charge,
ads are the only source of revenue they got. So these are important and we have
to make sure they are loaded and displayed correctly.  
The setup gets even more complicated because the client uses a "middleware" that
is based on DoubleClick as the technical foundation - leading to more and more 
scripts that have to be fetched from different servers (double *ouch*).  
DoubleClick offers an `<iframe>`-based "async" version of the [GPT][8] but we 
can't use it because the different ad-formats won't play well with iframes = 
even more synchronous JavaScript stopping the page from being rendered :(

Most of the time the first ad is located on the top of every page, so the aforementioned
scripts have to be loaded before this (in the `<head>`). Not 1, not 2, 
but 4 (in words: FOUR) scripts are loaded before the custom initialisation is 
run and the first ad can be displayed on page ... ah no, I forgot to mention 
that every ad loads one or more JS files to get the content they
need. <nobr>S-Y-N-C-H-R-O-N-O-U-S-L-Y.</nobr>

All these tracking and ad scripts push the "start render" back 4.5 seconds which
leads to readers looking at a blank screen for 8 seconds. If you're
lucky, they haven't left the site when the content starts trickling in.  
I'd also like to point to the fact that the webfonts are loaded long after the
"start render" at around 13 seconds which means that even though the browser 
starts to render the page, [copy isn't displayed][14] until they are downloaded 
completely.

Let's take a look at how this changes the page's waterfall:

[{% img /images/2014/01/waterfall-live-time-to-render.png 462 179 'waterfall for live site (time to render)' %}][12]

Concluding points 1 and 2 we have to realize that many 3rd party content 
providers just don't care about performance - at least not as much as we 
developers would like them to.

The last thing I want to talk about is point 3: real content.  
In our case we built templates for a home-, overview- and article-page using
dummy copy and images that nearly reflected real-life content (at least the 
amount we thought made sense considering our [performance budget][9]).  
The client was in too much of a "desktop-mode" and filled the landingpage with
everything that came to mind. So we ended up with around 50 article-teasers and 
multiple more complex gallery widgets etc.

[{% img /images/2014/01/waterfall-live-complete.png 462 791 'waterfall for live site (complete)' %}][13]

I don't say that it was there mistake (alone), we should have sat down with them 
more often and talked about how [peformance is a feature][10] and how it
(sometimes) is more important than an abundance of different content elements
put on the same page.

Points 1 and 2 destroyed our *time to first render* and 3 let the page get 
way too heavy for a "smooth surfing experience using a 3G network".

Let's not bury our heads in the sand and instead learn from a project like this.
But sometimes complaining again and again is enough to make all those shitty 3rd 
party widgets/scripts improve. At least I hope so.


  [1]: https://twitter.com/Souders
  [2]: https://twitter.com/stoyanstefanov
  [3]: https://twitter.com/jaffathecake
  [4]: https://twitter.com/guypod
  [5]: https://twitter.com/aerotwist
  [6]: https://twitter.com/jonathanklein
  [7]: https://segment.io/
  [8]: https://support.google.com/dfp_sb/answer/1649768?hl=en
  [9]: http://timkadlec.com/2013/01/setting-a-performance-budget/
  [10]: http://bradfrostweb.com/blog/post/performance-as-design/
  [11]: /images/2014/01/waterfall-templates-complete.png
  [12]: /images/2014/01/waterfall-live-time-to-render.png
  [13]: /images/2014/01/waterfall-live-complete.png
  [14]: https://twitter.com/jaffathecake/status/425629232543186944