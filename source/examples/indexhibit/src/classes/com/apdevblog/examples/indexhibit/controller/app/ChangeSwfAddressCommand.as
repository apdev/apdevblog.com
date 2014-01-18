package com.apdevblog.examples.indexhibit.controller.app 
{
	import com.asual.SWFAddress;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.utils.getQualifiedClassName;

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
	 * @version    SVN: $Id: ChangeSwfAddressCommand.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class ChangeSwfAddressCommand extends SimpleCommand 
	{
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(ChangeSwfAddressCommand));
		
		/**
		 * 
		 */
		override public function execute(note:INotification):void
		{
			var url:String = note.getBody() as String;
			if(url != null)
			{
				log.debug("execute() >>> url: " + url);			
				
				// change SWFAddress !
				SWFAddress.setValue(url);
			}
		}
	}
}
