package com.apdevblog.examples.indexhibit.view.components 
{
	import gs.TweenLite;
	import gs.easing.Cubic;
	import gs.easing.Quart;

	import com.apdevblog.examples.indexhibit.events.NavigationEvent;
	import com.apdevblog.examples.indexhibit.model.Constants;
	import com.apdevblog.examples.indexhibit.model.vo.ExhibitVo;
	import com.apdevblog.examples.indexhibit.view.content.BtnFullscreen;
	import com.apdevblog.examples.indexhibit.view.content.BtnGrid;
	import com.apdevblog.examples.indexhibit.view.content.ContentDetail;
	import com.apdevblog.examples.indexhibit.view.content.ExhibitCard;
	import com.apdevblog.examples.indexhibit.view.ui.CTextField;
	import com.apdevblog.utils.Draw;
	import com.apdevblog.utils.ui.AlignInfo;
	import com.apdevblog.utils.ui.AlignStage;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;

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
	 * @version    SVN: $Id: ContentContainer.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class ContentContainer extends Sprite 
	{	
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(ContentContainer));
		//
		private var _maxWidth:int;
		private var _maxHeight:int;
		private var _btn:BtnGrid;
		private var _cards:Array;
		private var _isRandom:Boolean;
		private var _cardsContainer:Sprite;
		private var _details:ContentDetail;
		private var _detailsMask:Shape;
		private var _currentExhibits:Array;
		private var _logo:CTextField;
		//
		private var _layerBg:Shape;
		private var _resizeTimer:Timer;
		private var _subpageOpen:Boolean;
		private var _btn2:BtnFullscreen;
		private var _sublogo:CTextField;

		/**
		 * 
		 */
		public function ContentContainer()
		{
			_init();
		}
		
		public function closeSubpage():void
		{
			_details.close();
			
			TweenLite.to(_cardsContainer, 0.8, {y:0, alpha:1, ease:Quart.easeOut});
			TweenLite.to(_detailsMask, 0.8, {scaleY:0, ease:Quart.easeOut});
		}
		
		public function openSubpage(exhibit:ExhibitVo):void
		{
			if(exhibit.url == "/")
			{
				_closeDetails();
				
				_sublogo.text = "";
			}
			else
			{
				if(_subpageOpen)
				{
					onLayerReady(exhibit.url);
				}
				else
				{
					// rearrange tiles to one big tile
					_subpageOpen = true;					
					_positionOpenCards();
					
					TweenLite.delayedCall(0.5, onLayerReady, [exhibit.url]);
				}
				
				var subtitle:String = "";
				if(exhibit.category != "")
				{
					subtitle += " / " + exhibit.category;
				}

				if(exhibit.title != "")
				{
					subtitle += " / " + exhibit.title;
				}
				_sublogo.text = subtitle.toLowerCase();
			}
		}
		
		private function _positionOpenCards(animate:Boolean=true):void
		{
			log.debug("_positionOpenCards("+animate+")");
			if(animate)
			{
				stage.quality = StageQuality.LOW;
			}
			
			var curx:int = 292 + Math.round( (stage.stageWidth - 585) * 0.5 ) - 173;		//- 140;
			var cury:int = 180 + Math.round( (stage.stageHeight - 360) * 0.5 ) + 33;
			
			for(var t:int=0;t<_cards.length;t++)
			{
				var card:ExhibitCard = _cards[t] as ExhibitCard;
				if(card != null)
				{
					card.hideContent();
					
					if(animate)
					{
						var obj:Object;
						if(card.scaleX >= 4.5)
						{
							obj = {x:curx + (Math.random() * 8 - Math.random() * 8), y:cury + (Math.random() * 8 - Math.random() * 8)};
							obj["rotation"] = card.rotation;						
						}
						else
						{
							obj = {x:curx + (Math.random() * 8 - Math.random() * 8), y:cury + (Math.random() * 8 - Math.random() * 8), scaleX:4.5, scaleY:4.5};
							obj["rotation"] = Math.random() * 8 - Math.random() * 8;
						}
						TweenLite.to(card, 0.4, obj);
					}
					else
					{
						//obj["rotation"] = card.rotation;
						
						card.x = curx;
						card.y = cury;
						//card.rotation = obj.rotation;
					}
				}
			}
			
			if(animate)
			{
				TweenLite.delayedCall(0.41, _toggleQuality, [StageQuality.HIGH]);
			}
		}

		private function _toggleQuality(quality:String):void
		{
			stage.quality = quality;
		}

		private function onLayerReady(url:String):void
		{
			var curx:int = 33;
			var cury:int = 170;
			
			if(_layerBg == null)
			{
				_layerBg = Draw.rect(585, 360, 0x000000, 1);
				addChildAt(_layerBg, getChildIndex(_details));
			}
		
			_layerBg.x = curx;
			_layerBg.y = cury;
			
			_details.x = curx + 20;
			_details.y = cury + 20;

			_cardsContainer.cacheAsBitmap = true;
			
			for(var i:int=0;i<_currentExhibits.length;i++)
			{
				var vo:ExhibitVo = _currentExhibits[i] as ExhibitVo;
				if(vo != null)
				{
					if(vo.url == url)
					{
						_details.setData(vo);
					}
					else
					{
						
					}
				}
			}
			
			_details.alpha = 0;
			
			TweenLite.to(_details, 0.4, {autoAlpha:1, ease:Cubic.easeOut});
		}

		private function _init():void
		{
			_maxWidth = Constants.STAGE_WIDTH - 100;
			_maxHeight = Constants.STAGE_HEIGHT - 100;
			
			_cards = [];
			_isRandom = true;
			_subpageOpen = false;
			
			_resizeTimer = new Timer(100, 1);
			_resizeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onResizeTimerComplete, false, 0, true);
			
			// logo
			_logo = new CTextField(CTextField.LOGO, "apdev / indexhibit", 20, 14);
			addChild(_logo);

			_sublogo = new CTextField(CTextField.LOGO_SUB, "", 20, 14);
			addChild(_sublogo);
			
			// cards container
			_cardsContainer = new Sprite();
			addChild(_cardsContainer);
			
			// details container
			_details = new ContentDetail();
			_details.visible = false;
			_details.x = 20;
			_details.y = 200;
			addChild(_details);			
			
			// dummy
			_btn = new BtnGrid();
			_btn.x = 500;
			_btn.y = 30;
			addChild(_btn);
			
			_btn.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
						
			// dummy 2
			_btn2 = new BtnFullscreen();
			_btn2.x = 550;
			_btn2.y = 30;
			addChild(_btn2);
			
			_btn2.addEventListener(MouseEvent.CLICK, onClick2, false, 0, true);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		private function onResizeTimerComplete(event:TimerEvent=null):void
		{
			log.debug("onResizeTimerComplete()");
			
			_maxWidth = stage.stageWidth - 100;
			_maxHeight = stage.stageHeight - 100;
			
			var startX:int = 85;

			var curx:int = startX;
			var cury:int = 140;
			
			var index:int = 0;
			
			var col:int = 0;
			var row:int = 0;
			
			var currentCategory:String;
			
			for(var i:int=0;i<_cards.length;i++)
			{				
				var card:ExhibitCard = _cards[i] as ExhibitCard;
//				log.debug(" >> " + card);
				if(card != null)
				{
					if(index > 0)
					{
						if(currentCategory != card.vo.category || curx >= stage.stageWidth - 70)
						{
							++row;
							col = 0;
							
							curx = startX;
							cury += 90;
						}
					}
					
					++index;
					
					card.originX = curx;
					card.originY = cury;
					card.randX = 65 + Math.random() * _maxWidth;
					card.randY = 100 + Math.random() * (_maxHeight-60);
					
					if(!_subpageOpen)
					{
						if(_isRandom)
						{
							TweenLite.to(card, 0.8, {x:card.randX, y:card.randY, ease:Cubic.easeOut});
						}
						else
						{
							TweenLite.to(card, 0.8, {x:card.originX, y:card.originY, ease:Cubic.easeOut});						
						}
					}
					
					++col;
					
					currentCategory = card.vo.category;
					
					curx += 140;
				}
			}
			
			//
			if(_subpageOpen)
			{
				_positionOpenCards(false);
			}
		}
		
		private function _closeDetails():void
		{
			if(!_subpageOpen)
			{
				return;
			}
			
			if(_layerBg != null)
			{
				removeChild(_layerBg);
				_layerBg = null;
				
				_details.visible = false;
				_details.close();
				
				_cardsContainer.cacheAsBitmap = false;
				
				_subpageOpen = false;
			}
			
			for(var i:int=0;i<_cards.length;i++)
			{
				var card:ExhibitCard = _cards[i] as ExhibitCard;
				if(card != null)
				{
					card.showContent();
					
					if(_isRandom)
					{
						TweenLite.to(card, 0.4, {x:card.randX, y:card.randY, rotation:card.randRotation, scaleX:1, scaleY:1});
					}
					else
					{
						TweenLite.to(card, 0.4, {x:card.originX, y:card.originY, rotation:0, scaleX:1, scaleY:1});			
					}
				}	
			}
		}

		private function onClick(event:MouseEvent):void
		{
			_randomize();
		}
		
		private function onClick2(event:MouseEvent):void
		{
			if(stage.displayState == StageDisplayState.NORMAL)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			else
			{
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		private function _randomize():void
		{			
			//_closeDetails();
			if(_subpageOpen)
			{
				dispatchEvent(new NavigationEvent(NavigationEvent.SELECT, true, true, "/"));
			}

			_isRandom = !_isRandom;
			
			for(var i:int=0;i<_cards.length;i++)
			{
				var card:ExhibitCard = _cards[i] as ExhibitCard;
				if(card != null)
				{
					card.showContent();
					
					if(_isRandom)
					{
						TweenLite.to(card, 0.4, {x:card.randX, y:card.randY, rotation:card.randRotation, scaleX:1, scaleY:1});
					}
					else
					{
						TweenLite.to(card, 0.4, {x:card.originX, y:card.originY, rotation:0, scaleX:1, scaleY:1});			
					}
				}	
			}
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_maxWidth = stage.stageWidth - 100;
			_maxHeight = stage.stageHeight - 100;
			
			AlignStage.getInstance().addItem(new AlignInfo(_logo, StageAlign.TOP_LEFT, 10, 14));
			AlignStage.getInstance().addItem(new AlignInfo(_sublogo, StageAlign.TOP_LEFT, 14, 14 + _logo.width + 4));
			
			AlignStage.getInstance().addItem(new AlignInfo(_btn, StageAlign.TOP_RIGHT, 14, -94));
			AlignStage.getInstance().addItem(new AlignInfo(_btn2, StageAlign.TOP_RIGHT, 14, -52));

			AlignStage.getInstance().addItem(new AlignInfo(_cardsContainer, StageAlign.TOP_LEFT, 0, 0));
			
			stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
		}
		
		private function onStageResize(event:Event):void
		{
			log.debug("onStageResize()");
			_maxWidth = stage.stageWidth - 100;
			_maxHeight = stage.stageHeight - 100;

			if(!_subpageOpen)
			{
				_resizeTimer.reset();
				_resizeTimer.start();
			}
			else
			{
				onResizeTimerComplete();
			}
		}

		public function update(exhibits:Array):void
		{
			log.debug("update() >>> " + exhibits);
			
			_currentExhibits = [];
			
			var curx:int = 85;
			var cury:int = 140;
			
			var index:int = 0;
			
			var col:int = 0;
			var row:int = 0;
			
			exhibits.sortOn("order", Array.NUMERIC);
			
			var currentCategory:String;
			
			for(var i:int=0;i<exhibits.length;i++)
			{
				var vo:ExhibitVo = exhibits[i] as ExhibitVo;
				if(vo != null && vo.url != "/")
				{
					_currentExhibits.push(vo);
					
					if(index > 0)
					{
						if(currentCategory != vo.category || curx >= stage.stageWidth - 70)
						{
							++row;
							col = 0;
							
							curx = 85;
							cury += 90;
						}
					}
					
					++index;
					var item:ExhibitCard = new ExhibitCard(vo);
					
					item.x = item.originX = curx;
					item.y = item.originY = cury;
					item.randX = 65 + Math.random() * _maxWidth;
					item.randY = 100 + Math.random() * (_maxHeight-60);
					
					item.x = item.randX;
					item.y = item.randY;
					
					item.alpha = 0;
					
					item.randRotation = 20 - Math.random()*40;
					
					item.rotation = item.randRotation; 
					
					_cardsContainer.addChild(item);
					
					TweenLite.to(item, 0.8, {alpha:1, ease:Cubic.easeOut, delay:0.05*i});

					_cards.push(item);
					
					++col;
					
					currentCategory = vo.category;
					
					curx += 140;					
				}
			}
		}
	}
}
