package com.apdevblog.examples.indexhibit 
{
	import com.apdevblog.examples.indexhibit.model.Constants;
	import com.apdevblog.examples.indexhibit.utils.log.LoggerInit;
	import com.apdevblog.utils.ui.AlignStage;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.fscommand;
	import flash.utils.getDefinitionByName;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 *
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit
	 * @author     phil / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: Index.as 12 2009-09-17 19:26:01Z phil $
	 */
	[SWF(backgroundColor="#ffffff", frameRate="30", width="990", height="640")]
	public class Index extends MovieClip 
	{
		public static const MAIN_CLASS:String = "com.apdevblog.examples.indexhibit.Main";
		//
		
		/**
		 * 
		 */
		public function Index()
		{
			stop();
			_init();
		}
		
		private function _init():void
		{
			LoggerInit.init(loaderInfo.parameters["testMode"]);
			
			fscommand("showmenu", "false");
			AlignStage.getInstance().init(stage, Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT);	//  StageAlign.TOP_LEFT	
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}
		
		private function _initMain():void 
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			var mainClass:Class = Class(getDefinitionByName(Index.MAIN_CLASS));
			if(mainClass) 
			{
				var app:Object = new mainClass();
				addChildAt(app as DisplayObject, 0);
			}
		}
		
		private function onEnterFrame(event:Event):void
		{
			if(framesLoaded == totalFrames) 
			{
				nextFrame();
				_initMain();
			}
			else 
			{
                // Show loading stuff here ...
			}
		}
	}
}
