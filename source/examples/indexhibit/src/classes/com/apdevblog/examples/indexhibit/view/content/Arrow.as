package com.apdevblog.examples.indexhibit.view.content 
{
	import com.apdevblog.examples.indexhibit.model.Constants;	
	
	import flash.display.Graphics;
	import flash.display.Sprite;	

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
	public class Arrow extends Sprite 
	{
		public static const RIGHT:String = "right";
		public static const LEFT:String = "left";
		//
		private var _direction:String;
		
		public function Arrow(direction:String = Arrow.RIGHT)
		{
			_init(direction);
		}
		
		private function _draw():void
		{
			var g:Graphics = graphics;
			
			g.beginFill(Constants.COLOR_GREEN, 1);
			g.drawRect(0, 0, 10, 8);
			g.drawRect(10, -1, 1, 10);
			g.drawRect(11, 0, 1, 8);
			g.drawRect(12, 1, 1, 6);
			g.drawRect(13, 2, 1, 4);
			g.drawRect(14, 3, 1, 2);
			g.endFill();
		}

		private function _init(direction:String):void
		{
			_direction = direction;
			
			_draw();
		}
	}
}
