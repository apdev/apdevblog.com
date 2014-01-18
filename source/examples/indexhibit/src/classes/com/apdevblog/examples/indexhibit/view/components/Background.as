package com.apdevblog.examples.indexhibit.view.components 
{
	import com.apdevblog.examples.indexhibit.model.Constants;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.view.components
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: Background.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class Background extends Sprite 
	{
		private var _bg:Shape;

		/**
		 * 
		 */
		public function Background()
		{
			
		}
		
		private function _resizeBg():void
		{			
			_bg.width = stage.stageWidth; 
			_bg.height = stage.stageHeight;
			
			_bg.x = Math.round((Constants.STAGE_WIDTH - _bg.width) * 0.5); 
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_resizeBg();
			
			stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
		}
		
		private function onStageResize(event:Event):void
		{
			_resizeBg();			
		}
	}
}
