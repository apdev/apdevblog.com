package com.apdevblog.examples.indexhibit.view.content 
{
	
	import gs.TweenLite;
	import gs.easing.Quart;

	import com.apdevblog.examples.indexhibit.events.NavigationEvent;
	import com.apdevblog.examples.indexhibit.model.vo.ExhibitVo;
	import com.apdevblog.examples.indexhibit.view.ui.CTextField;
	import com.apdevblog.utils.Draw;

	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.view.components.content
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: ExhibitCard.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class ExhibitCard extends Sprite 
	{
		private var _vo:ExhibitVo;

		private var _bg:Shape;
		private var _label:CTextField;
		private var _arrow:Arrow;

		private var _bgColor:int;
		
		private var _originX:Number;
		private var _originY:Number;
		private var _randX:Number;
		private var _randY:Number;
		private var _randRotation:Number;
		private var _container:Sprite;

		/**
		 * 
		 */
		public function ExhibitCard(vo:ExhibitVo)
		{
			_init(vo);
		}
		
		public function showContent():void
		{
			_label.visible = true;
			mouseEnabled = true;
		}

		public function hideContent():void
		{
			_label.visible = false;
			mouseEnabled = false;
		}

		private function _draw():void
		{
			blendMode = BlendMode.MULTIPLY;
			cacheAsBitmap = true;
			
			_container = new Sprite();
			_container.x = -65;
			_container.y = -40;
			addChild(_container);
			
			_bg = Draw.rect(130, 80, _bgColor, 1);
			_container.addChild(_bg);

			_label = new CTextField(CTextField.CARD_TITLE, _vo.title.toLowerCase(), 7, 5, 100, 68);
			_container.addChild(_label);
		}

		private function _init(vo:ExhibitVo):void
		{
			_vo = vo;
			mouseChildren = false;
			mouseEnabled = true;
			buttonMode = true;
			
			_bgColor = _getBgColor(_vo.category);
			
			_draw();
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		private function _getBgColor(category:String):int
		{
			var clr:int = 0;
			switch(category)
			{
				case "Websites": clr = 0x00FFFF; break; 
				case "Games": clr = 0xFFFF00; break; 
				case "Applications": clr = 0xFF00FF; break; 
//				case "2007": clr = 0x00FFFF; break; 
//				case "2008": clr = 0xFF00FF; break; 
//				case "2009": clr = 0xFFFF00; break; 
			}
			
			return clr;
		}

		private function onClick(event:MouseEvent):void
		{
			//TweenLite.to(_overMask, 0.4, {scaleY:1, ease:Cubic.easeOut});
			//TweenLite.to(_normalMask, 0.4, {scaleY:0, ease:Cubic.easeOut});
			
			dispatchEvent(new NavigationEvent(NavigationEvent.SELECT, true, true, _vo.url));
		}

		private function onMouseOut(event:MouseEvent):void
		{
			TweenLite.to(_label, 0.6, {tint:null, ease:Quart.easeOut});
			TweenLite.to(_arrow, 0.6, {x:115, autoAlpha:0, ease:Quart.easeOut});
		}

		private function onMouseOver(event:MouseEvent):void
		{
			TweenLite.to(_label, 0.6, {tint:0x000000, ease:Quart.easeOut});
			TweenLite.to(_arrow, 0.6, {x:125, autoAlpha:1, ease:Quart.easeOut});			
		}

		public function get randX():Number
		{
			return _randX;
		}
		
		public function set randX(randX:Number):void
		{
			_randX = randX;
		}
		
		public function get randY():Number
		{
			return _randY;
		}
		
		public function set randY(randY:Number):void
		{
			_randY = randY;
		}
		
		public function get randRotation():Number
		{
			return _randRotation;
		}
		
		public function set randRotation(randRotation:Number):void
		{
			_randRotation = randRotation;
		}
		
		public function get originX():Number
		{
			return _originX;
		}
		
		public function set originX(originX:Number):void
		{
			_originX = originX;
		}
		
		public function get originY():Number
		{
			return _originY;
		}
		
		public function set originY(originY:Number):void
		{
			_originY = originY;
		}
		
		public function get vo():ExhibitVo
		{
			return _vo;
		}
	}
}
