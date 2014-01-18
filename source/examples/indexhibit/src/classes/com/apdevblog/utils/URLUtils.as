package com.apdevblog.utils
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;	
	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.utils
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: SelectPageCommand.as 8 2009-08-31 14:05:34Z phil $
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
		public static const SELF:String = "_self";
		public static const BLANK:String = "_blank";
		//
		protected static const WINDOW_OPEN_FUNCTION:String = "window.open";
		
		public static function addHTTP(url:String):String
		{
			if(checkHTTP(url))
			{
				url = "http://" + url;
			}
			return url;
		}

		public static function checkHTTP(url:String):Boolean
		{
			return url.indexOf("http://") != -1;
		}
		
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
				ExternalInterface.call("function setWMWindow() {window.open('" + url + "', '"+window+"');}");
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

		private static function getBrowserName():String
		{
			var browser:String;
            
			//Uses external interface to reach out to browser and grab browser useragent info.
			var browserAgent:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
        
			//Determines brand of browser using a find index. If not found indexOf returns (-1).
			if(browserAgent != null && browserAgent.indexOf("Firefox") >= 0) 
			{
				browser = "Firefox";
			} 
            else if(browserAgent != null && browserAgent.indexOf("Safari") >= 0)
			{
				browser = "Safari";
			}             
            else if(browserAgent != null && browserAgent.indexOf("MSIE") >= 0)
			{
				browser = "IE";
			}         
            else if(browserAgent != null && browserAgent.indexOf("Opera") >= 0)
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
