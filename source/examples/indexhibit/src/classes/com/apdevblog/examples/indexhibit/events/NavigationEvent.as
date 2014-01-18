package com.apdevblog.examples.indexhibit.events 
{
	import flash.events.Event;	

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.events
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: NavigationEvent.as 122 2009-05-05 13:34:30Z phil $
	 */
	public class NavigationEvent extends Event 
	{
		public static const SELECT:String = "navigationSelect";
		public static const PREV_SUBPAGE:String = "navigationPrevSubpage";
		public static const NEXT_SUBPAGE:String = "navigationNextSubpage";
		//
		private var _url:String;

		/**
		 * 
		 */
		public function NavigationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, url:String = null)
		{
			super(type, bubbles, cancelable);
			_url = url;
		}
		
		public function get url():String
		{
			return _url;
		}
	}
}
