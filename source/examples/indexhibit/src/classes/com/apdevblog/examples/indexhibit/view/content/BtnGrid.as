package com.apdevblog.examples.indexhibit.view.content 
{
	import com.apdevblog.utils.Draw;

	import flash.display.Shape;
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
	public class BtnGrid extends Sprite 
	{
		private var _bg:Shape;
		
		public function BtnGrid()
		{
			buttonMode = true;
			
			_bg = Draw.rect(30, 16, 0xFFFFFF, 0);
			addChild(_bg);
			
			addChild(Draw.rect(6, 4, 0x000000, 1, 0, 0));
			addChild(Draw.rect(6, 4, 0x000000, 1, 8, 0));
			addChild(Draw.rect(6, 4, 0x000000, 1, 16, 0));
			addChild(Draw.rect(6, 4, 0x000000, 1, 24, 0));

			addChild(Draw.rect(6, 4, 0x000000, 1, 0, 6));
			addChild(Draw.rect(6, 4, 0x000000, 1, 8, 6));
			addChild(Draw.rect(6, 4, 0x000000, 1, 16, 6));
			addChild(Draw.rect(6, 4, 0x000000, 1, 24, 6));

			addChild(Draw.rect(6, 4, 0x000000, 1, 0, 12));
			addChild(Draw.rect(6, 4, 0x000000, 1, 8, 12));
			addChild(Draw.rect(6, 4, 0x000000, 1, 16, 12));
			addChild(Draw.rect(6, 4, 0x000000, 1, 24, 12));
		}
	}
}
