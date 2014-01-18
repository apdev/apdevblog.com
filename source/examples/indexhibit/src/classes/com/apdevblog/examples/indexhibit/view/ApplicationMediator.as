package com.apdevblog.examples.indexhibit.view
{
	
	import com.apdevblog.examples.indexhibit.view.components.Background;
	import com.apdevblog.examples.indexhibit.view.components.ContentContainer;

	import org.puremvc.as3.patterns.mediator.Mediator;
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
	 * @package    com.apdevblog.indexhibit.view
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: ApplicationMediator.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class ApplicationMediator extends Mediator 
	{
		public static const NAME:String = "ApplicationMediator";
		//
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(ApplicationMediator));
		
		/**
		 * 
		 */
		public function ApplicationMediator(viewComponent:DisplayObjectContainer)
		{
			log.debug("ApplicationMediator(" + viewComponent + ")");
			super(ApplicationMediator.NAME, viewComponent);
		}
		
		private function _init():void
		{
			// background
			var bg:Background = new Background();
			main.addChild(bg);
			
			// content
			var content:ContentContainer = new ContentContainer();
			facade.registerMediator(new ContentMediator(content));
			main.addChild(content);
			
			
			// stats
//			var stats:Stats = new Stats();
//			main.addChild(stats);
		}
		
		override public function onRegister():void
		{
			_init();
		}
		
		public function get main():DisplayObjectContainer
		{
			return viewComponent as DisplayObjectContainer;
		}
	}
}
