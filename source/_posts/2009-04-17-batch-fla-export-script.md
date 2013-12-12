---
title: Batch fla export script
author: Aron
layout: post
date: 2009-04-17 00:00:00 +0100
comments: true
permalink: /batch-fla-export-script/
syntaxhighlighter_encoded:
  - 1
categories:
  - Misc
tags:
  - Flash
  - IDE
  - jsfl
---
We recently finished a pretty untypical project. The client wanted to have a portfolio site, where the &#8220;cases&#8221;-pages were so different, that they did not fit in any cms or xml structure. And since the client has their own flash developer (well, more of a designer type&#8230;) they wanted to be able to maintain the FLA files themselves.

So we built the basic structure in an index.swf. The &#8220;cases&#8221; FLAs had a document class which inherited from a super class. So what if something in the superclass changes? Yes, you have to open every FLA and export it all over again.

For this case we wrote a little JSFL script with a XUL user interface. Interestingly this feature exists since Flash MX 2004 without much notice. 

<!--more-->

Screenshots:

![][1]  
![][2]  
![][3]  
![][4]

<span style="font-size:16px; font-weight:bold">How to:</span>

*   Select if you want to include subdirectories
*   Select the directory
*   Select a string
*   Hit Ok. The script will take care of the rest

<span style="font-size:16px; font-weight:bold">Features:</span>

*   Compatible with Flash MX 2004, Flash 8, Flash CS3 and Flash CS4 on OSX and Windows  
    (Flash MX 2004 and Flash 8 does not report compiler errors)
*   Saves settings for next use
*   Reports if there was compiler errors
*   Includes subdirectories

<span style="font-size:16px; font-weight:bold"><a href="/stuff/batchflaexport/BatchFlaExport.mxp">Download</a></span> (Make sure, you have the [Adobe Extension Manager][5] installed)

<span style="font-size:16px; font-weight:bold">For developers:</span>

You can have a look at the [jsfl file here][6].

The GUI is build in XML2UI (which is a subcategory of [xul][7]). Its available since Flash MX 2004 and so it is documented. Although google finds something, you&#8217;ll ofter get a 404 when clicking some interesting sounding links. It took me ages to find out that there are livedocs about that in the [Flash 8 livedocs][8], not inside &#8220;Extending Flash&#8221; but inside &#8220;Using Flash&#8221; -> &#8220;XML to UI&#8221;. Well, right.

You can not pass parameters to the xul xml (which you would need to implement the prefilling). That why you first need to write an XML file with the xml parameters and then pass this xml file to the xmlPanel() method (remember to delete this file after usage).

The same for the fl.compilerErrors object. This object does not have a value or text parameter but it can be saved to the file system. So you need to save that to a file, read this file and check if there is content in this file. If no, there were no compiler errors.

Feel free to write a comment if you have any questions. 

 [1]: /stuff/batchflaexport/batchFlaExport-01.gif
 [2]: /stuff/batchflaexport/batchFlaExport-02.gif
 [3]: /stuff/batchflaexport/batchFlaExport-03.gif
 [4]: /stuff/batchflaexport/batchFlaExport-04.gif
 [5]: http://www.adobe.com/exchange/em_download/
 [6]: /stuff/batchflaexport/Batch Fla Export.jsfl
 [7]: https://developer.mozilla.org/en/XUL
 [8]: http://livedocs.adobe.com/flash/8/main/wwhelp/wwhimpl/js/html/wwhelp.htm