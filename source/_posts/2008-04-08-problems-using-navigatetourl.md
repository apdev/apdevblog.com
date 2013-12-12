---
title: Problems using navigateToURL
author: Phil
layout: post
date: 2008-04-08 00:00:00 +0100
comments: true
permalink: /problems-using-navigatetourl/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - browser
  - Flash
  - popupblocker
  - swfobject
---
Hi there&#8230; we&#8217;ve been busy these past couple of days so there wasn&#8217;t much time for new posts &#8211; sorry. But here is a little update.  
While developing a flash website (AS3 & <a title="SWFObject" href="http://code.google.com/p/swfobject/" target="_blank">SWFObject2.0</a>) that heavily depended on opening URLs in a new browser window we came across the popup blocker problem that the use of navigateToURL causes. When trying to open a new window firefox&#8217;/IE&#8217;s popup blocker will block the window and display its warning. After googling for some time we came across some neat workarounds:

<!--more-->

1) <a title="Prevent popups" href="http://skovalyov.blogspot.com/2007/01/how-to-prevent-pop-up-blocking-in.html" target="_blank">How to prevent pop-up blocking in Firefox by Sergey Kovalyov</a>

2) <a title="nightmare _blank" href="http://thesaj.wordpress.com/2008/02/12/the-nightmare-that-is-_blank-part-ii-help/" target="_blank">The Nightmare that is &#8220;_blank&#8221;: Part II (resolved???) by The Saj</a>

putting these two approaches into one AS3 util-class, this is what we came up with:

<pre class="brush: as3; title: ; notranslate" title="">package com.apdevblog.utils
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;	
	/**
	 * Collection of URL util functions.
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.utils
	 * @author     Philipp Kyeck / phil@apdevblog.com
	 * @copyright  2008 apdevblog.com
	 * @version    SVN: $Id: URLUtils.as 19 2008-04-08 09:57:50Z phil $
	 *
	 * based on script by
	 * @author Sergey Kovalyov
	 * @see http://skovalyov.blogspot.com/2007/01/how-to-prevent-pop-up-blocking-in.html
	 * 
	 * and based on script by
	 * @author Jason the Saj
	 * @see http://thesaj.wordpress.com/2008/02/12/the-nightmare-that-is-_blank-part-ii-help
	 */
	public class URLUtils    
	{
		protected static const WINDOW_OPEN_FUNCTION:String = "window.open";
		
		/**
		 * Open a new browser window and prevent browser from blocking it.
		 * 
		 * @param url        url to be opened
		 * @param window     window target
		 * @param features   additional features for window.open function
		 */
		public static function openWindow(url:String, window:String = "_blank", features:String = ""):void 
		{
			var browserName:String = getBrowserName();
			
			if(getBrowserName() == "Firefox")
			{
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
            //If IE, 
            else if(browserName == "IE")
			{
				ExternalInterface.call("function setWMWindow() {window.open('" + url + "');}");
			}
            //If Safari 
            else if(browserName == "Safari")
			{              
				navigateToURL(new URLRequest(url), window);
			}
            //If Opera 
            else if(browserName == "Opera")
			{    
				navigateToURL(new URLRequest(url), window); 
			}
            //Otherwise, use Flash's native 'navigateToURL()' function to pop-window. 
            //This is necessary because Safari 3 no longer works with the above ExternalInterface work-a-round.
            else
			{
				navigateToURL(new URLRequest(url), window);
			}
		}
		
		/**
		 * return current browser name.
		 */
		private static function getBrowserName():String
		{
			var browser:String;
            
			//Uses external interface to reach out to browser and grab browser useragent info.
			var browserAgent:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
        
			//Determines brand of browser using a find index. If not found indexOf returns (-1).
			if(browserAgent != null && browserAgent.indexOf("Firefox") &gt;= 0) 
			{
				browser = "Firefox";
			} 
            else if(browserAgent != null && browserAgent.indexOf("Safari") &gt;= 0)
			{
				browser = "Safari";
			}             
            else if(browserAgent != null && browserAgent.indexOf("MSIE") &gt;= 0)
			{
				browser = "IE";
			}         
            else if(browserAgent != null && browserAgent.indexOf("Opera") &gt;= 0)
			{
				browser = "Opera";
			}
            else 
			{
				browser = "Undefined";
			}
			return (browser);
		}
	}
}
</pre>

You also have to set the wmode inside your containing html file to &#8220;opaque&#8221; and the allowScriptAccess to &#8220;always&#8221;.

<pre class="brush: as3; title: ; notranslate" title="">// emdbedding swf w/ swfobject
var width="400";
var height="150";
var flashVersion = "9.0.0";
var movie = "navigatetourl.swf";
var movieName = "flashMovie";
var bgColor = "#000000";
var express = "expressInstall.swf";
var replaceDiv = "flashcontent";

var flashvars = {};

var params = {};
params.wmode = "opaque";
params.allowScriptAccess = "always";

var attributes = {};
attributes.id = "myFlashMovie";

swfobject.embedSWF(movie, replaceDiv, width, height, flashVersion,
               express, flashvars, params, attributes);
</pre>

Here is also a working example: <a title="navigateToUrl example" href="http://apdevblog.com/examples/navigatetourl/" target="_blank">navigateToURL example</a>.  
And you can download the <a title="download example" href="http://apdevblog.com/examples/navigatetourl/navigatetourl.zip" target="_self">sourcecode</a>.

cheers 