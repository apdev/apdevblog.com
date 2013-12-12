---
title: Having fun with ActionScript3, E4X and XPath
author: Aron
layout: post
date: 2009-08-25 00:00:00 +0100
comments: true
permalink: /actionscript3-e4x-and-xpath/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - E4X
  - XML
  - XPath
---
I admit, I was still a bit wet behind the ears when it came to working with XML in AS3 &#8211; never did more then getting some images for a slideshow or loading some config-stuff out of a tiny 6-lines XML document. I thought, working with XML in Flash is still some myXML.firstChild.firstChild.firstChild.nodeValue bulls**t. 

For a recent project, I had the chance to actually dive into this [E4X magic][1] and do the tricks. And yes, although I would still prefer using everything as serialized AMF, working with XML in Flash makes sense &#8230; now. And it&#8217;s definitely fun.

<!--more-->

The guys from [memorphic][2] wrote a great AS3 XPath library. [Download it here][3]. 

<span style="font-size:16px; font-weight:bold">Working with optional nodes and not-known depths</span>

For most cases, the E4X implementation works perfectly well. However, it gets difficult when you are dealing with nodes that might or might not exist. Example coming up next:

<pre class="brush: xml; title: ; notranslate" title="">&lt;data&gt;
  &lt;group&gt;
    &lt;id&gt;first&lt;/id&gt;
    &lt;field&gt;
      &lt;id&gt;firstname&lt;/id&gt;
    &lt;/field&gt;
    &lt;field&gt;
      &lt;id&gt;lastname&lt;/id&gt;
      &lt;errorId&gt;001&lt;/errorId&gt;
    &lt;/field&gt;
  &lt;/group&gt;
  &lt;group&gt;
    &lt;id&gt;second&lt;/id&gt;
    &lt;field&gt;
      &lt;id&gt;email&lt;/id&gt;
    &lt;/field&gt;
    &lt;group&gt;
      &lt;id&gt;address&lt;/id&gt;
      &lt;field&gt;
        &lt;id&gt;street&lt;/id&gt;
        &lt;errorId&gt;001&lt;/errorId&gt;
      &lt;/field&gt;
      &lt;field&gt;
        &lt;id&gt;zip&lt;/id&gt;
        &lt;errorId&gt;002&lt;/errorId&gt;
      &lt;/field&gt;
    &lt;/group&gt;
  &lt;/group&gt;
&lt;/data&gt;
</pre>

With AS3 you cannot check against optional nodes:

<pre class="brush: as3; title: ; notranslate" title="">trace(xdata..field.(errorId == "001").id); 
// throws an exception, since errorId exists only in some nodes
</pre>

The XPath implementation from memorphic is working just fine:

<pre class="brush: as3; title: ; notranslate" title="">var xpq : XPathQuery = new XPathQuery("/");
xpq.path = "//field[errorId = '001']/id";
trace(xpq.exec(xdata));

Output:
&lt;id&gt;lastname&lt;/id&gt;
&lt;id&gt;street&lt;/id&gt;
</pre>

Now I want to know every group that contains an error &#8211; regardless of the depth.

<pre class="brush: as3; title: ; notranslate" title="">// get me all group ids that contain error(s) regardless of the depth of the error
var xpq : XPathQuery = new XPathQuery("/");
xpq.path = "//group[*//errorId]/id";
trace(xpq.exec(xdata));

Output:
&lt;id&gt;first&lt;/id&gt;
&lt;id&gt;second&lt;/id&gt;
&lt;id&gt;address&lt;/id&gt;
</pre>

Why all this stuff? I need to know the first hierarchy group (&#8230; they&#8217;re representing pages in my project) that contains errors (somewhere in the depth of this group). Here we go:

<pre class="brush: as3; title: ; notranslate" title="">// get me first hierarchy group that contains error(s)
var xpq : XPathQuery = new XPathQuery("/");
xpq.path = "/data/group[*//errorId][1]/id";
trace(xpq.exec(xdata));

Output:
first
</pre>

<span style="font-size:16px; font-weight:bold">Get the XPath</span>

Although it is obviously a bad habit, there can be nodes, that have non-unique ids. In case you need to save a path to that node, you need to get the XML path (literally the XPath).

<pre class="brush: xml; title: ; notranslate" title="">&lt;data&gt;
  &lt;group&gt;
    &lt;id&gt;taf1&lt;/id&gt;
  &lt;field&gt;
    &lt;id&gt;tellafriend_name&lt;/id&gt;
    &lt;label&gt;name&lt;/label&gt;
  &lt;/field&gt;
  &lt;field&gt;
    &lt;id&gt;tellafriend_email&lt;/id&gt;
    &lt;label&gt;email&lt;/label&gt;
  &lt;/field&gt;
&lt;/group&gt;
  &lt;group&gt;
    &lt;id&gt;taf2&lt;/id&gt;
  &lt;field&gt;
    &lt;id&gt;tellafriend_name&lt;/id&gt;
    &lt;label&gt;name&lt;/label&gt;
  &lt;/field&gt;
  &lt;field&gt;
    &lt;id&gt;tellafriend_email&lt;/id&gt;
    &lt;label&gt;email&lt;/label&gt;
  &lt;/field&gt;
&lt;/group&gt;
&lt;/data&gt;
</pre>

<pre class="brush: as3; title: ; notranslate" title="">for each(var field:XML in xdata..field)
{
	trace(XPathUtils.findPath(field, xdata));
}

Output:
/data/group[1]/field[1]
/data/group[1]/field[2]
/data/group[2]/field[1]
/data/group[2]/field[2]
</pre>

However, the nodes have to be somehow different from each other, i.e. by having different parent nodes (like in the example) or different child nodes / values. If this is not the case, it&#8217;s not working. Example:

<pre class="brush: xml; title: ; notranslate" title="">&lt;data&gt;
&lt;field&gt;
  &lt;id&gt;tellafriend_name&lt;/id&gt;
  &lt;label&gt;name&lt;/label&gt;
&lt;/field&gt;
&lt;field&gt;
  &lt;id&gt;tellafriend_name&lt;/id&gt;
  &lt;label&gt;name&lt;/label&gt;
&lt;/field&gt;
&lt;field&gt;
  &lt;id&gt;tellafriend_name&lt;/id&gt;
  &lt;label&gt;name&lt;/label&gt;
&lt;/field&gt;
&lt;/data&gt;

Output:
/data/field[1]
/data/field[1]
/data/field[1]
</pre>

<span style="font-size:16px; font-weight:bold">Getting node index</span>

Sorry, this is not possible directly with AS3 E4X or XPath. You need to have a helper function for that.

<pre class="brush: xml; title: ; notranslate" title="">&lt;data&gt;
  &lt;field&gt;
    &lt;id&gt;testfield1&lt;/id&gt;
  &lt;/field&gt;
  &lt;field&gt;
    &lt;id&gt;testfield2&lt;/id&gt;
  &lt;/field&gt;
  &lt;field&gt;
    &lt;id&gt;testfield3&lt;/id&gt;
  &lt;/field&gt;
&lt;/data&gt;
</pre>

<pre class="brush: as3; title: ; notranslate" title="">var myfield:XML = xdata.field.(id == "testfield2")[0];
var fields:XMLList = xdata.field;
			
for (var i : int = 0; i &lt; fields.length(); i++) 
{
	if(myfield == fields[i])
	{
		trace("found "+i);
	}
}
</pre>

Please correct me, as I said before, I&#8217;m new to this stuff&#8230; ;)

cheers 

 [1]: http://en.wikipedia.org/wiki/ECMAScript_for_XML
 [2]: http://www.memorphic.com/news/
 [3]: http://code.google.com/p/xpath-as3/