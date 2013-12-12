---
title: Flex DataGrid revisited
author: Phil
layout: post
date: 2009-08-31 00:00:00 +0100
comments: true
permalink: /flex-datagrid-revisited/
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
Hi there &#8230; some weeks ago I blogged about my struggles with Flex and its built-in DataGrid. After some time of getting to know &#8220;my Grid&#8221;, I decided to refactor the <a href="http://apdevblog.com/flex-datagrid-impressions-of-a-flex-noob/" target="_blank">previous example</a>.

<!--more-->

To begin with here&#8217;s the new demo &#8230; (<a href="http://apdevblog.com/examples/apdev_datagrid2/srcview/" target="_blank">sourceview</a>)  
<div id="swfd5513">
  This movie requires Flash Player 9
</div>

  
It pretty much looks the same as last time but I changed some things behind the scenes &#8211; that being:

1) I excluded the ComboBox for selecting a new item from the actual DataGrid and added a HBox that handles the selection underneath.

<pre class="brush: as3; title: ; notranslate" title="">&lt;mx:HBox
  width="500" height="29"
  paddingLeft="5" paddingTop="2"
  borderSides="left right"
  borderThickness="1" borderColor="#b7babc" borderStyle="solid"
  horizontalGap="0"
  backgroundColor="{_arr.length % 2 == 0 ? 0xf7f7f7 : 0xFFFFFF}"
  visible="{_checkVisibility()}"
  includeInLayout="{_checkVisibility()}"
  &gt;

  &lt;mx:Box width="16" height="20" paddingTop="2"&gt;
    &lt;mx:Image source="{imgAdd}"
      width="16" height="16"
            verticalCenter="0"
            verticalAlign="middle"
            horizontalAlign="center"
         /&gt;
  &lt;/mx:Box&gt;

  &lt;mx:Spacer width="5" /&gt;

  &lt;mx:ComboBox
    id="addExpenseCmb"
    prompt="Add expense ..."
    height="20"
    maxHeight="20"
    dataProvider="{_vals}"
    change="onChangeAddCost(event);"
  /&gt;

&lt;/mx:HBox&gt;
</pre>

2) The text-part&#8217;s ItemRenderer (first column in grid) was replaced by the standard renderer.

<pre class="brush: as3; title: ; notranslate" title="">&lt;mx:DataGridColumn 
  headerText="Question"
  width="260" 
  editable="false"
  resizable="false" 
  draggable="false" 
  sortable="false" 
  wordWrap="true"
  dataField="question" 
  /&gt;
</pre>

After a while of working with the previous solution I was really getting bugged with the ComboBox (and everything that came with it) being a part of the ItemRenderer and hence a part of the DataGrid itself. So I decided to exclude the addition of new values/expenses from the normal view of the data (makes sense, doesn&#8217;t it ;) ). So one can still dynamically add rows to the DataGrid, but this is done by an independent component, handling all the extra weight.

I also did some charting with the grid&#8217;s data, maybe i&#8217;ll have the time to wrap up another example including the delicious-looking PieCharts :)

Cheers

PS: I only used one of their icons, but <a href="http://www.famfamfam.com/" target="_blank">famfamfam</a> did a great job of putting together a really huge set of free <a href="http://www.famfamfam.com/lab/icons/silk/" target="_blank">icons</a>. 