---
layout: post
title: "Current state of input[type=range]"
date: 2014-01-22 21:17:28 +0100
published: false
author: Aron
comments: true
permalink: /current-state-of-input-range
categories:
  - HTML
  - HTML5
  - CSS
tags:
  - HTML
  - HTML5
  - markup
  - CSS
  - forms
---
{% img /images/input-range-3d.jpg 500 279 %}

Recently I did the mobile version of a product site. The desktop version involved a slider with a relatively complex styling. The slider was a critical part of the business logic so it needed to be implemented in the mobile version as well. I was planing to do a no-jQuery, inline-CSS, very-few-request highly optimized site and was absolutely not willing to introduce jQuery mobile with all their dependecies.

Because:
<blockquote class="twitter-tweet" lang="en"><p>Pro tip: to improve your JavaScript performance, stop using JavaScript.</p>&mdash; Pamela Fox (@pamelafox) <a href="https://twitter.com/pamelafox/statuses/403587732548509696">November 21, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

I digged around a little and since all the old IE's were not on my agenda, I played around with input[type=range] a little. And it's fairly supported.

<p data-height="268" data-theme-id="0" data-slug-hash="nlyrf" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/aronwoost/pen/nlyrf'>Cross browser custom styled input[type=range]</a> by Aron Woost (<a href='http://codepen.io/aronwoost'>@aronwoost</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>