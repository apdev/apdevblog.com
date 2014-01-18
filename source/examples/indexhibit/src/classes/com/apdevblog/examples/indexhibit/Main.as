package com.apdevblog.examples.indexhibit
{
	import com.apdevblog.examples.indexhibit.model.vo.ExhibitVo;
	import com.apdevblog.examples.indexhibit.model.vo.ImageVo;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.registerClassAlias;
	import flash.text.Font;

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
	 * @version    SVN: $Id: Main.as 16 2009-09-17 19:33:54Z phil $
	 */
	public class Main extends Sprite 
	{
		[Embed(source='/../assets/fonts/TimesNewRomanMTStd.otf', fontName='TimesNewRoman', mimeType="application/x-font")] 
		private var TimesNewRoman:Class;	// unicodeRange='U+0020-U+007E'

		[Embed(source='/../assets/fonts/TimesNewRomanMTStd-Italic.otf', fontName='TimesNewRomanItalic', fontStyle='italic', mimeType="application/x-font")] 
		private var TimesNewRomanItalic:Class;	// unicodeRange='U+0020-U+007E'
		
		/**
		 * 
		 */
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		private function _init():void
		{
			registerClassAlias("com.apdevblog.examples.indexhibit.model.vo.ExhibitVo", ExhibitVo);
			registerClassAlias("com.apdevblog.examples.indexhibit.model.vo.ImageVo", ImageVo);
			
			Font.registerFont(TimesNewRoman);
			Font.registerFont(TimesNewRomanItalic);
			
			var facade:ApplicationFacade = ApplicationFacade.getInstance();
			facade.startup(this);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_init();
		}
	}
}
