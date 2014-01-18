package com.apdevblog.examples.indexhibit.controller.app 
{
	import gs.OverwriteManager;
	
	import com.apdevblog.examples.indexhibit.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import flash.display.DisplayObjectContainer;		

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
	 * @version    SVN: $Id: ViewPrepCommand.as 4 2009-05-26 18:24:33Z phil $
	 */
	public class ViewPrepCommand extends SimpleCommand 
	{
		override public function execute(note:INotification):void
		{
			OverwriteManager.init(OverwriteManager.AUTO);
			
			var main:DisplayObjectContainer = note.getBody() as DisplayObjectContainer;			
			facade.registerMediator(new ApplicationMediator(main));
		}
	}
}
