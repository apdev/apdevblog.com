package com.apdevblog.text
{
	import flash.text.TextFormat;	
	
	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.text
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2008 beta_interactive
	 * @version    SVN: $Id: VTextFormat.as 133 2008-06-25 16:34:46Z phil $
	 */
	public class ApdevTextFormat extends TextFormat
	{
		private var _styleName:String;
		
	// constructor	///////////////
		
		/**
		 * @inheritDoc
		 */
		public function ApdevTextFormat(font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null)
		{
			super(font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
		}
		
	// getter / setter	///////////////
		
		/**
		 * textformat's stylename.
		 */
		public function get styleName():String
		{
			return _styleName;
		}
		
		/**
		 * @private
		 */
		public function set styleName(styleName:String):void
		{
			_styleName = styleName;
		}
	}
}
