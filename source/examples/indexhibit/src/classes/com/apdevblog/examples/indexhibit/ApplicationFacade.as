package com.apdevblog.examples.indexhibit
{
	import com.apdevblog.examples.indexhibit.controller.app.ChangeHtmlTitleCommand;
	import com.apdevblog.examples.indexhibit.controller.app.ChangeSwfAddressCommand;
	import com.apdevblog.examples.indexhibit.controller.app.SelectPageCommand;
	import com.apdevblog.examples.indexhibit.controller.app.StartupCommand;
	import com.apdevblog.examples.indexhibit.model.IndexhibitProxy;

	import org.puremvc.as3.patterns.facade.Facade;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: ApplicationFacade.as 8 2009-08-31 14:05:34Z phil $
	 */
	public class ApplicationFacade extends Facade 
	{
		public static const STARTUP:String = "startup";
		//
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(ApplicationFacade));
		
		/**
		 * 
		 */
		public static function getInstance():ApplicationFacade
		{
			if(instance == null) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		/**
		 * 
		 */
		public function startup(main:DisplayObjectContainer):void
		{
			log.debug("startup() >>> " + main);
			sendNotification(ApplicationFacade.STARTUP, main);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function initializeController():void
		{
			super.initializeController();
			
			registerCommand(ApplicationFacade.STARTUP, StartupCommand);
			registerCommand(IndexhibitProxy.CHANGE_PAGE, ChangeSwfAddressCommand);
			registerCommand(IndexhibitProxy.SELECT_PAGE, SelectPageCommand);
			registerCommand(IndexhibitProxy.UPDATE_TITLE, ChangeHtmlTitleCommand);		
		}
	}
}
