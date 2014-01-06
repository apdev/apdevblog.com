---
title: How to save the positions of annotations in epubs (or html)
author: Aron
layout: post
date: 2012-07-30 00:00:00 +0100
comments: true
permalink: /how-to-save-the-positions-of-annotations-in-epubs-or-html/
categories:
  - HTML5
  - JavaScript
tags:
  - ebook
  - epub
  - html
  - HTML5
  - JavaScript
  - XPath
---
The biggest advantage of ebooks over printed ones is &#8211; of course &#8211; that there are no more fixed pages. Every device can decide how it wants to display the content. With digital books it is possible to have the same excellent user experience on a small smartphone screen as well as on a huge desktop monitor.

But with all these advantages there also come challenges. One is positioning inside the book. So what to do, when you want to save the user&#8217;s current reading position, so that he can continue on the same &#8220;page&#8221; when he comes back? Since the user can read the text on different devices with different screen resolutions and different text settings (e.g. font size settings) you can not simply save &#8220;Page 36&#8243;.

<!--more-->

### Last read page (rough position)

If you just want the rough position (i.e. no certain text) the plain percentage is a way to go. The <a href="https://github.com/joseph/Monocle" target="_blank">monocle framework</a> (that we use at <a href="http://nim.bi/" target="_blank">Nimbi</a> and <a href="http://paperc.com/" target="_blank">PaperC</a>) <a href="https://github.com/joseph/Monocle/issues/116" target="_blank">does exactly that</a>. It saves the reading position by dividing the current page number by the total number of pages (base on the rendering on the current device). On a smartphone the user might be on page 50 of 100 pages total where he is on page 6 of 12 pages total on his desktop browser. Both lead to roughly the same position.

We must be aware that there is a certain cognitive load for the user to find his actual last sentence on a page when changing devices or even changing from portait to landscape mode on his tablet. We have no chance to save the actual last words the user read.

### Certain text

When it comes to saving annotations we need something more accurate. The user wants to highlight a certain sentence. We need a way to save the exact text so we can allow the user to navigate to that text directly and visually highlight the text.

### Text and offset (or index)

Just saving the selected string as text and do a full text search when trying to find the string won&#8217;t do the job, since finding the actual word is impossible when the user selected a word like e.g. &#8220;and&#8221;. So together with the actual string we need *at least* an offset from the beginning of the text (which is usually a chapter in ebooks, also called component).

This is a typical way to deal with search results. Search engines usually deliver results based on full text search. When they index a HTML document they strip away all markup leaving the text only. So what they can give you is the found string and an offset (numbers of characters) from the beginning of the document. A result for a term like &#8220;and&#8221; (which is usually a <a href="http://en.wikipedia.org/wiki/Stop_words" target="_blank">stop word</a> in search engines) will contain different offsets for the same term.

The bad news is, that in order for the offset to be accurate, you need to make sure that your local text-online version of the HTML document is *exactly the same* as the one your search engine indexed. You need to know exactly how/if the search engine converts linebreaks to spaces and how the search engine deals with spaces/linebreaks between DOM nodes (and other things). And then you have to apply these rules to the implementations on your client.

To avoid the &#8220;offset-hell&#8221; you could tell your search engine to deliver an index of the appearance in the document instead of an offset. Assuming you have three appearances of the term &#8220;and&#8221; the search engine could deliver the index 0, 1 or 2 to a result dataset. With that you are always certain which term you are dealing with.

Either way it&#8217;s not trivial to first convert the markup to text-only and then, after you found the term, find this term back in your DOM tree. Also note, that operations on huge amounts of text can be CPU-intensive, especially on mobile devices.

### DOM based

Back to the case where a user wants to highlight a portion of text. Why not letting the DOM help us a little. We can make use of the <a href="https://developer.mozilla.org/en/DOM/range" target="_blank">Range obj</a>.

&#8220;The Range object represents a fragment of a document that can contain nodes and parts of text nodes in a given document.&#8221;

That seems like the perfect fit for our use case. And it is! While it&#8217;s not supported by every browser environment it is well supported on engines that are typically used for displaying ebook (epub) content. For our &#8220;and&#8221; example it would look like this (jQuery pseuso code):
{% gist 3209510 example1.js %}

The range of a more complex text (that runs over more that one DOM node) could look like this (user selected &#8220;Prejudice is a book&#8221;):
{% gist 3209510 example2.js %}

This is a good starting point for describing fragments of text embedded in html. If you want to locate the visual position of this range you can call  
{% gist 3209510 example3.js %}


### How to save it in the backend

For saving the dataset to the backend we need a string representation of the DOM elements. Different approaches are possible. As XPath it could look something like this:  
{% gist 3209510 example4.js %}
  
Or, if you don&#8217;t want to rely on elements to have id&#8217;s or classes:
{% gist 3209510 example5.js %}

  
Yap, in Xpath the index starts with 1. 

However, for Nimbi and PaperC we tried to keep the data smaller (it&#8217;s potentially big data, right?) and query language agnostic:  
{% gist 3209510 example6.js %}
  
startContainer and endContainer are the first textnode in the frist childNode of body (i.e. body.childNodes[0].childNodes[0]). The dataset is smaller (less to send over the wire and to save in the db) and &#8211; more importantly &#8211; it does not rely on XPath. While XPath might not be the bottleneck in this kind of application, it is known for not necessarily being fast, especially on mobile devices. And there is no XPath on Android < 2.4.

Here is an example of a more complex DOM tree:  
{% gist 3209510 example7.js %}
  
This pretty much solved the position issue for us.

### Pros

The position is 100% unique. You&#8217;ll find the fragment no matter the screen size or font settings. You can even save the position of a single character.

It makes use of the most basic HTML. The DOM tree was there since Day 1 of the HTML standard. So even the oldest and most outdated html parser should be able to find the fragment.

It&#8217;s query agnostic. You don&#8217;t need XPath or other stuff.

Very small data footprint.

### Cons

Since the position is described in a DOM tree, the backend needs a XML/HTML parser to &#8220;understand&#8221; the position. Asume that you want the backend to create a &#8220;heatmap&#8221; of the book, where the users set highlights, where they stopped reading and so on. The backend will have to convert the position to it&#8217;s own positioning format (if it is not using the DOM tree in the first place).

Also the implementation relies on a valid DOM. Epub components (a html chapter of an epub) are typically XHTML. If they are not served with mimetype application/xhtml the browser will fall into quirks mode. When you now have DOM elements that are only valid according to XHTML they will not correctly hook into the DOM tree. Since we are using a numeric tree representation (e.g. 12/0/4/0) one invalid DOM element can mess up the whole tree and we won&#8217;t be able to find the elements. While this may sound scary, setting the correct mimetype will fix the issue entirely.

### Last reading position 2.0

Eventually we decided to also use this approach to save the user&#8217;s last reading position. We now save the first character on a page as the current reading position. We thought back and forth if we might should take a character somewhere from the middle of the page. However with the first character approach we can be sure, that the user always sees something that he has already read, so that he can easily find the last read sentence.

### What&#8217;s next?

Well, the hard part is &#8211; of course &#8211; to let the user select text (hint: window.getSelection()) and to visually highlight text fragments. But this is something for another blog post&#8230; :)