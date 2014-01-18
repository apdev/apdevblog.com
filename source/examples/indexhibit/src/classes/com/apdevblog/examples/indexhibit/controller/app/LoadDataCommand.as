package com.apdevblog.examples.indexhibit.controller.app 
{
	import com.apdevblog.examples.indexhibit.model.IndexhibitProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;	

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
	 * @version    SVN: $Id: LoadDataCommand.as 2 2009-05-26 14:43:23Z phil $
	 */
	public class LoadDataCommand extends SimpleCommand 
	{
		override public function execute(note:INotification):void
		{
			var ndxz:IndexhibitProxy = facade.retrieveProxy(IndexhibitProxy.NAME) as IndexhibitProxy;
			ndxz.getAllExhibits();
		}
	}
}
