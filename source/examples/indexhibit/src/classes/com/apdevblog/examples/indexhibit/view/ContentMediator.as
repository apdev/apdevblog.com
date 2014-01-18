package com.apdevblog.examples.indexhibit.view
{
	import com.apdevblog.examples.indexhibit.events.NavigationEvent;
	import com.apdevblog.examples.indexhibit.model.IndexhibitProxy;
	import com.apdevblog.examples.indexhibit.model.vo.ExhibitVo;
	import com.apdevblog.examples.indexhibit.view.components.ContentContainer;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.view
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: ContentMediator.as 8 2009-08-31 14:05:34Z phil $
	 */
	public class ContentMediator extends Mediator 
	{
		public static const NAME:String = "ContentMediator";
		public static const CHANGE_FILTER:String = "contentChangeFilter";
		public static const FILTER_CHANGED:String = "contentFilterChanged";
		//
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(ContentMediator));
		
		/**
		 * 
		 */
		public function ContentMediator(viewComponent:ContentContainer)
		{
			super(ContentMediator.NAME, viewComponent);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function listNotificationInterests():Array 
		{
			return [
					IndexhibitProxy.EXHIBITS_CHANGED,
					IndexhibitProxy.PAGE_CHANGED,
					ContentMediator.FILTER_CHANGED
					];
		}

		/**
		 * @inheritDoc
		 */ 
		override public function handleNotification(note:INotification):void 
		{
			log.debug("handleNotification() >>> " + note.getName());
			switch(note.getName())
			{
				case IndexhibitProxy.PAGE_CHANGED:
					content.openSubpage(note.getBody() as ExhibitVo);
				break;

				case IndexhibitProxy.EXHIBITS_CHANGED:
					content.update(note.getBody() as Array);
				break;
			}
		}

		override public function onRegister():void
		{
			content.addEventListener(NavigationEvent.SELECT, onContentChangeUrl, false, 0, true);
			content.addEventListener(Event.CLOSE, onContentClose, false, 0, true);
		}
		
		private function onContentClose(event:Event):void
		{
			log.debug("onContentClose()");
			sendNotification(IndexhibitProxy.SELECT_PAGE, "/");
		}

		private function onContentChangeUrl(event:NavigationEvent):void
		{
			sendNotification(IndexhibitProxy.SELECT_PAGE, event.url);
		}

		/**
		 * 
		 */
		public function get content():ContentContainer
		{
			return viewComponent as ContentContainer;
		}
	}
}
