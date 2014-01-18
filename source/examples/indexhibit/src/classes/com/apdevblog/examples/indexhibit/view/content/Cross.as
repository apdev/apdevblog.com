package com.apdevblog.examples.indexhibit.view.content 
{
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
	public class Cross extends Sprite 
	{
		public function Cross()
		{
			_init();
		}
		
		private function _draw():void
		{
			var g:Graphics = graphics;
			
			g.beginFill(0xFFFFFF, 1);			
			g.drawRect(0, 0, 18, 18);
			g.endFill();
			
			g.beginFill(0x000000, 1);
			
			g.drawRect(0, 0, 18, 1);
			g.drawRect(0, 1, 1, 16);
			g.drawRect(17, 1, 1, 16);
			g.drawRect(0, 17, 18, 1);
			
			g.drawRect(3, 3, 1, 1);
			g.drawRect(4, 4, 1, 1);
			g.drawRect(5, 5, 1, 1);
			g.drawRect(6, 6, 1, 1);
			g.drawRect(7, 7, 1, 1);
			g.drawRect(8, 8, 1, 1);
			g.drawRect(9, 9, 1, 1);
			g.drawRect(10, 10, 1, 1);
			g.drawRect(11, 11, 1, 1);
			g.drawRect(12, 12, 1, 1);
			g.drawRect(13, 13, 1, 1);
			g.drawRect(14, 14, 1, 1);
			
			g.drawRect(3, 14, 1, 1);
			g.drawRect(4, 13, 1, 1);
			g.drawRect(5, 12, 1, 1);
			g.drawRect(6, 11, 1, 1);
			g.drawRect(7, 10, 1, 1);
			g.drawRect(8, 9, 1, 1);
			g.drawRect(9, 8, 1, 1);
			g.drawRect(10, 7, 1, 1);
			g.drawRect(11, 6, 1, 1);
			g.drawRect(12, 5, 1, 1);
			g.drawRect(13, 4, 1, 1);
			g.drawRect(14, 3, 1, 1);
						
			g.endFill();
		}

		private function _init():void
		{
			mouseEnabled = true;
			buttonMode = true;
			
			_draw();
		}
	}
}
