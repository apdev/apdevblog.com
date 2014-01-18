package com.apdevblog.examples.indexhibit.view.content 
{
	import gs.TweenLite;

	import com.apdevblog.utils.Draw;

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
	 * @author     phil / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id$
	 */
	public class BtnFullscreen extends Sprite 
	{
		private var _bg:Shape;
		private var _bg2:Shape;
		private var _rect:Sprite;

		public function BtnFullscreen()
		{
			buttonMode = true;
			
			_bg = Draw.rect(30, 16, 0x000000, 1);
			addChild(_bg);
			
			_bg2 = Draw.rect(28, 14, 0xFFFFFF, 1, 1, 1);
			addChild(_bg2);
			
			_rect = new Sprite();
			_rect.x = 15;
			_rect.y = 8;
			var outline:Shape = Draw.outline(30, 16, 0x000000, 1);
			outline.x = -15;
			outline.y = -8;
			_rect.addChild(outline);
			addChild(_rect);
			
			_rect.alpha = 0;
			
			_rect.scaleX = 0.2;
			_rect.scaleY = 0.2;
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
		}
		
		private function onMouseOut(event:MouseEvent):void
		{
			TweenLite.to(_rect, 0.6, {alpha:0, scaleX:0.2, scaleY:0.2});
		}

		private function onMouseOver(event:MouseEvent):void
		{
			TweenLite.to(_rect, 0.6, {alpha:1, scaleX:1, scaleY:1});			
		}
	}
}
