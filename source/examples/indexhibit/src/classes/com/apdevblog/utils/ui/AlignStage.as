package com.apdevblog.utils.ui 
{
	import flash.display.DisplayObject;	
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;	

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 *
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.indexhibit
	 * @author     phil / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: Index.as 8 2009-08-31 14:05:34Z phil $
	 */
	public class AlignStage 
	{
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(AlignStage));
		//
		protected static var _instance:AlignStage;
		
		private var _items:Array;
		private var _adjustables:Array;
		
		protected var _stage:Stage;
		private var _stageAlign:String;
		private var _stageWidth:uint;
		private var _stageHeight:uint;
		
		/**
		 * static functions
		 */
		public static function getInstance():AlignStage
		{
			if(_instance == null) _instance = new AlignStage();
			return _instance;
		}
		
		/**
		 * constructor
		 */
		public function AlignStage()
		{
			if(_instance != null) throw new Error("Error: Instantiation failed: Only one AlignStage object allowed.");
		}
		
		/**
		 * public methods
		 */
		public function addAdjustable(obj:IStageAdjustable):void
		{
			log.debug("addAdjustable() >>> " + obj);
			_adjustables.push(obj);
			
			onResizeStage();
		}

		public function addItem(info:AlignInfo):void
		{
			log.debug("addItem() >>> " + info.item + " " + info.align);
			_deleteDuplicates(info);
			_items.push(info);
			
			onResizeStage();
		}
		
		public function init(stage:Stage, width:uint, height:uint, stageAlign:String=""):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, onResizeStage, false, 0, true);
			stage.align = stageAlign;
			
			_stage = stage;
			_stageAlign = stageAlign;
			_stageWidth = width;
			_stageHeight = height;
			
			_items = [];
			_adjustables = [];
		}
		
		public function removeAdjustable(obj:IStageAdjustable):void
		{
			log.debug("removeAdjustable() >>> " + obj);
			
			var adjustable:IStageAdjustable;
			for(var i:int=0;i<_adjustables.length;i++)
			{
				adjustable = _adjustables[i] as IStageAdjustable;
				if(adjustable == null) continue;
				
				if(adjustable == obj)
				{
					log.debug("duplicate found !!! >>> " + adjustable);
					_adjustables.splice(i, 1);
					log.debug("spliced !!! >>> " + _adjustables);
					--i;
				}
			}
		}

		public function removeItem(info:*):void
		{
			log.debug("removeItem() >>> " + info);
			_deleteDuplicates(info);
			
			// TODO: check if necessary? onResizeStage();
		}

		/**
		 * private methods
		 */		
		private function _align(info:AlignInfo):void
		{
			try
			{
				log.debug("_align() " + info.item);
				log.debug("_align() " + info.item.stage);
				log.debug("_align() " + info.item.stage.stageHeight + "//" + _stageHeight);
				log.debug(" >>> " + info.item.stage.stageWidth + "//" + _stageWidth);
				log.debug(" >>> _stageAlign " + _stageAlign);
			}
			catch(err:Error)
			{
				log.error(err.message);
				return;
			}
			
			var aligns:Array = info.align.split("");			
			for(var j:int=0;j<aligns.length;j++)
			{
				var newx:Number;
				var newy:Number;
				
				if(aligns[j] == StageAlign.TOP)
				{
					if(_stageAlign.substr(0,1) == StageAlign.BOTTOM)
					{
						newy = _stageHeight - info.item.stage.stageHeight + info.vpad;
					}
					else if(_stageAlign.substr(0,1) == StageAlign.TOP)
					{
						newy = info.vpad;
					}
					else
					{
						newy = (_stageHeight - info.item.stage.stageHeight)/2 + info.vpad;
					}
				}
				else if(aligns[j] == StageAlign.BOTTOM)
				{
					if(_stageAlign.substr(0,1) == StageAlign.BOTTOM)
					{
						newy = _stageHeight + info.vpad;
					}
					else if(_stageAlign.substr(0,1) == StageAlign.TOP)
					{
						newy = _stageHeight + (info.item.stage.stageHeight - _stageHeight) + info.vpad;
					}
					else
					{
						newy = _stageHeight + (info.item.stage.stageHeight - _stageHeight)/2 + info.vpad;
					}
				}
				else if(aligns[j] == StageAlign.LEFT)
				{
					if(_stageAlign.substr(0,1) == StageAlign.LEFT || _stageAlign.substr(1,1) == StageAlign.LEFT)
					{
						newx = info.hpad;
					}
					else if(_stageAlign.substr(0,1) == StageAlign.RIGHT || _stageAlign.substr(1,1) == StageAlign.RIGHT)
					{
						newx = _stageWidth - info.item.stage.stageWidth + info.hpad;
					}
					else
					{
						newx = (_stageWidth - info.item.stage.stageWidth)/2 + info.hpad;
					}
				}
				else if(aligns[j] == StageAlign.RIGHT)
				{
					if(_stageAlign.substr(0,1) == StageAlign.LEFT || _stageAlign.substr(1,1) == StageAlign.LEFT)
					{
						newx = _stageWidth + info.item.stage.stageWidth - _stageWidth + info.hpad;
					}
					else if(_stageAlign.substr(0,1) == StageAlign.RIGHT || _stageAlign.substr(1,1) == StageAlign.RIGHT)
					{
						newx = _stageWidth + info.hpad;
					}
					else
					{
						newx = _stageWidth + (info.item.stage.stageWidth - _stageWidth)/2 + info.hpad;
					}
				}
				
				log.debug("item:" + info.item);
				if(!isNaN(newx))
				{
					log.debug("x:" + newx);
					info.item.x = Math.round(newx);
				}
				if(!isNaN(newy))
				{
					log.debug("y:" + newy);
					info.item.y = Math.round(newy);
				}
				
			}
		}
		
		private function _deleteDuplicates(info:*):void
		{
			log.debug("_deleteDuplicates()");
			
			var toBeDeleted:DisplayObject;
			if(info is DisplayObject)
			{
				 toBeDeleted = info as DisplayObject;
			}
			else if(info is AlignInfo)
			{
				toBeDeleted = (info as AlignInfo).item;
			}
			else
			{
				log.error("_deleteDuplicates() >>> PARAMETER NOT RECOGNIZED");
				return;
			}
			
			var tempInfo:AlignInfo;
			for(var i:int= 0 ; i<_items.length; i++)
			{
				tempInfo = _items[i] as AlignInfo;
				if(tempInfo == null) continue;
				
				log.debug("duplicate? " + toBeDeleted + " =? " + tempInfo.item + " same? " + (toBeDeleted == tempInfo.item));
				if(toBeDeleted == tempInfo.item)
				{
					log.debug("duplicate found !!! >>> " + toBeDeleted);
					_items.splice(i, 1);
					log.debug("spliced !!! >>> " + _items);
					--i;
				}
			}
		}

		/**
		 * event listener
		 */
		private function onResizeStage(e:Event=null):void
		{
			log.debug("onResizeStage()");
			if(_items != null && _items.length > 0)
			{
				for(var i:int=0;i<_items.length;i++)
				{
					log.debug(i + " >> " + _items[i]);
					_align(_items[i]);
				}
			}

			if(_adjustables != null && _adjustables.length > 0)
			{
				var adjustable:IStageAdjustable;
				for(var ii:int=0;ii<_adjustables.length;ii++)
				{
					adjustable = _adjustables[ii] as IStageAdjustable;
					if(adjustable == null) continue;
					
					adjustable.onStageResize(e);
				}
			}
		}
		
		/**
		 * getter / setter
		 */
		public static function get STAGE():Stage
		{
			return getInstance()._stage;
		}

		public static function get STAGE_ALIGN():String
		{
			return getInstance()._stageAlign;
		}
	}
}