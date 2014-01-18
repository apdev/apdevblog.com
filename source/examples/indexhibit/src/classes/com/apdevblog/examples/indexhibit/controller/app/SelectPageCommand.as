package com.apdevblog.examples.indexhibit.controller.app 
{
	import com.apdevblog.examples.indexhibit.model.IndexhibitProxy;
	import com.apdevblog.utils.URLUtils;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.controller.app 
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: SelectPageCommand.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class SelectPageCommand extends SimpleCommand 
	{
		/**
		 * 
		 */
		override public function execute(note:INotification):void
		{
			var url:String = note.getBody() as String;
			if(url != null)
			{
				if(URLUtils.checkHTTP(url))
				{
					// open absolute url as html in same window
					navigateToURL(new URLRequest(url), "_self");
				}
				else
				{
					sendNotification(IndexhibitProxy.CHANGE_PAGE, url);
				}
			}
		}
	}
}
