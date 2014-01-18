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
	 * @version    SVN: $Id: DataPrepCommand.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class DataPrepCommand extends SimpleCommand 
	{
		override public function execute(note:INotification):void
		{
			facade.registerProxy(new IndexhibitProxy());
		}
	}
}
