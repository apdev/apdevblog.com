---
title: 'Flex DataGrid &#8211; impressions of a Flex noob'
author: Phil
layout: post
date: 2009-07-20 00:00:00 +0100
comments: true
permalink: /flex-datagrid-impressions-of-a-flex-noob/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flex
tags:
  - ActionScript
  - DataGrid
  - Flex
  - ItemRenderer
---
Hiho. Been busy these last couple of weeks &#8230; For me it&#8217;s the first time looking deeper into this whole Flex stuff. And Aron is getting his hand dirty with iPhone development and Google Web Toolkit (GWT). But as the title already says, this post is all about Flex.

Right now, I&#8217;m building some Flex-modules that are heavily data-driven &#8211; that&#8217;s basically why I chose Flex in the first place. After trying to build my own datagrids and excel-like tables in Flash/AS3 I quickly decided to turn to Flex and use the built-in components to get everything working.

So &#8230;. after getting to know Flex a little better, I can say one thing for sure: I don&#8217;t really like it :)  
You got components for almost everything, but if your requirements differ just a bit from the features the flex-components offer, you are screwed. and especially the DataGrid &#8211; it&#8217;s very easy to get some rows out of your database and display them in the grid, but don&#8217;t event try to use complex data &#8230; then everything crashes and you have to write dozens ans dozens of ItemRenderers and work-arounds to display the data in the DataGrid.  
yadda yadda yadda &#8230; I&#8217;m still working my butt off to get everything as I want it to be &#8211; but I thought I&#8217;ll share my thoughts and especially my &#8220;tricks&#8221; with you.

<!--more-->

First of all I want to thank Peter deHaan for his great Flex-blog (<http://blog.flexexamples.com/>) &#8211; I got so many little things off of his blog. I think also there may be some lines of code in the example, that I copied from him. Secondly there is this post, I read about &#8220;dynamically adding rows to a DataGrid&#8221; that I used as a guide to implement my own DataGrid (<http://www.switchonthecode.com/tutorials/adding-dynamic-rows-to-flex-datagrid>). So again &#8211; thanks to you!

Here are the requirements I had to fulfill for one of my own DataGrids:

*   dynamically add rows to DataGrid
*   dynamically adjust height of DataGrid
*   the user should be able to input money-values
*   calculate sum of all inserted values
*   use ComboBox within DataGrid as ItemRenderer
*   ComboBox should define a time-interval for the money-values

So this is what I came up with &#8211; you can see for yourself. (<a href="http://apdevblog.com/examples/apdev_datagrid/srcview/" target="_blank">sourceview</a> / <del datetime="2009-07-20T16:02:05+00:00">rightclick</del>)  
<div id="swfd5512">
  This movie requires Flash Player 9
</div>

  
Some tricky things were e.g. the dynamic height of the DataGrid &#8211; I had to use a custom function to calculate the height every time the data within the DataGrid changed.

<pre class="brush: as3; title: ; notranslate" title="">private function _calculateHeight():void
{
  if(grid.dataProvider)
  {
    var len:int = grid.dataProvider.length;
    _gridHeight = grid.measureHeightOfItems(-1, len);
  }
}
</pre>

And then there was the adding of the rows itself &#8211; as I mentioned earlier, I found this [post][1] about how to add rows dynamically and just adapted it for my purposes.

<pre class="brush: as3; title: ; notranslate" title="">private function onCollectionChanged(event:CollectionEvent):void
{
    // check if last row is != 0
    var obj:Object = _arr.getItemAt(_arr.length-1);
    if(obj.question != 0 && _arr.length &lt; MAX_EXPENSES)
    {
        _arr.addItem({question:0, timeInterval:0, timeIntervalEditable:false, money:0});
        return;
    }
    
    // check if timeInterval == 0
    for(var i:int = _arr.length-1; i &gt;= 0; i--)
    {
        obj = _arr.getItemAt(i);
        if(obj.question != 0 && obj.timeInterval == 0)
        {
            _arr.removeItemAt(i);
            return;
        }
    }
    
    // update height
    _calculateHeight();
    _updateTotal();
}
</pre>

Another problem was the update-process of my own ItemRenderers &#8211; e.g. the one with the ComboBox to select the time-interval. After changing the value of the ComboBox the DataGrid never got the COLLECTION_CHANGED event and I couldn&#8217;t update the &#8220;total&#8221; at the bottom of the DataGrid. So back to google and again looking for a solution &#8230; I found this somewhere:

<pre class="brush: as3; title: ; notranslate" title="">private function forceUpdate():void
{
    //log.debug("forceUpdate()");
    // Access the collection - listData.owner is the DataGrid and from there you have its dataProvider.
    var ac:ArrayCollection = (listData.owner as DataGrid).dataProvider as ArrayCollection;
    
    data.question = cmb.selectedItem.val;
    
    if(cmb.selectedItem.val != 0)
    {                    
        data.timeInterval = 1;
        data.timeIntervalEditable = true;
    }
    
    // finally, tell the collection the data changed. this will cause the collection to
    // dispatch its own change event which is then picked up by the main application.
    ac.itemUpdated(data);
}
</pre>

Now everything worked fine and I could update the &#8220;total&#8221; everytime the user changed a value in the DataGrid.  
For the rest of the code, just check the &#8220;view source&#8221; of the swf. I haven&#8217;t had the time to comment the code in detail, but the code is pretty much self-explanatory &#8211; once you got all the pieces together ;)

I haven&#8217;t mentioned it, but I&#8217;m still working with FlexBuilder3 and not the new &#8220;[Gumbo][2]&#8220;-Release &#8211; in which Adobe overhauled all components.

Soooo &#8230; hope this post is of any help to you and I spare you the many hours looking for answers that I had to waste.

Cheers 

 [1]: http://www.switchonthecode.com/tutorials/adding-dynamic-rows-to-flex-datagrid
 [2]: http://labs.adobe.com/technologies/flashbuilder4/?sdid=EUILX