package com.apdevblog.examples.indexhibit.view.ui 
{
	import com.apdevblog.examples.indexhibit.model.Constants;
	import com.apdevblog.text.ApdevTextField;
	import com.apdevblog.text.ApdevTextFormat;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.view
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2008 beta_interactive
	 * @version    SVN: $Id: CTextField.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class CTextField extends ApdevTextField 
	{
		public static const LOGO:String = "logo";
		public static const LOGO_SUB:String = "logoSub";
		//
		public static const CARD_TITLE:String = "cardTitle";
		//
		public static const DETAILS_TITLE:String = "detailsTitle";
		public static const DETAILS_COPY:String = "detailsCopy";
		//
		public static const DEFAULT_WIDTH:int = 20;
		public static const DEFAULT_HEIGHT:int = 10;
		//
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(CTextField));
		//
		private var _dotted:Boolean;
		private var _maxLines:int;
						
		
		/**
		 * constructor.
		 */
		public function CTextField(	style:String, 
									label:String = "", 
									x:int = 0, 
									y:int = 0, 
									width:int = 0, 
									height:int = 0, 
									dotted:Boolean = false,
									maxLines:int = -1)
		{			
			_dotted = dotted;
			_maxLines = maxLines;
			
			super(style, label, x, y, width, height);
		}
		
		/**
		 * @inheritDoc
		 */
		protected override function _setStyle(style:String):Array
		{
			var tf:ApdevTextFormat = new ApdevTextFormat();
			var styles:StyleSheet;
			
			embedFonts = true;
			selectable = false;
			
			switch(style) 
			{
				//
				case CTextField.LOGO:
					tf.font = Constants.TimesNewRomanItalic;
					tf.color = 0x000000;
					tf.size = 48;
					
					tf.kerning = true;
					tf.letterSpacing = -2;
					
					tf.leading = 0;
					
					autoSize = TextFieldAutoSize.LEFT;
					break;
				//
				case CTextField.LOGO_SUB:
					tf.font = Constants.TimesNewRomanItalic;
					tf.color = 0x000000;
					tf.size = 24;
					
					tf.kerning = true;
					tf.letterSpacing = -1;
					
					tf.leading = 0;
					
					autoSize = TextFieldAutoSize.LEFT;
					break;
				//
				case CTextField.CARD_TITLE:
					tf.font = Constants.TimesNewRomanItalic;
					tf.color = 0xFFFFFF;
					tf.size = 15;
					tf.kerning = true;
					tf.leading = 0;
					
					multiline = true;
					wordWrap = true;
					
					autoSize = TextFieldAutoSize.LEFT;
					break;
				//
				case CTextField.DETAILS_TITLE:
					tf.font = Constants.TimesNewRomanItalic;
					tf.color = 0x000000;
					tf.size = 22;
					
					tf.kerning = true;
					tf.leading = 0;
					
					tf.kerning = true;
					tf.letterSpacing = -0.5;
					
					autoSize = TextFieldAutoSize.LEFT;
					break;
				//
				case CTextField.DETAILS_COPY:
					tf.font = Constants.TimesNewRoman;
					tf.color = 0x000000;
					tf.size = 12;
					
					tf.kerning = true;
					tf.letterSpacing = 0.3;
					
					tf.leading = 0.2;
					
					//antiAliasType = AntiAliasType.NORMAL;
					multiline = true;
					wordWrap = true;
					
					mouseEnabled = true;
					
					styles = new StyleSheet();
//					styles.setStyle("a", {color:"#" + Constants.COLOR_GREEN.toString(16), textDecoration:"none"});
					styles.setStyle("a", {color:"#FF00FF", textDecoration:"none"});
					styles.setStyle("a:hover", {textDecoration:"underline"});
					
					autoSize = TextFieldAutoSize.LEFT;
					break;

				// DEFAULT ////////////////////////////////////
										
				default:
					tf.font = "_sans";
					tf.size = 11;
					tf.color = 0xFF0000;
					
					embedFonts = false;
					autoSize = TextFieldAutoSize.LEFT;
					break;
			}
			
			// 
			if(_dotted && _maxLines == -1)
			{
				// disable autoSize when dotted == true and not multiline
				autoSize = TextFieldAutoSize.NONE;
			}
			
			return [tf, styles];
		}
		
		public override function set htmlText(txt:String):void
		{
			super.htmlText = txt;
			
			if(_dotted) 
			{
				var pos:int;
				var short:String;
				
				log.debug(" !!! " + txt + " !!! ");
				log.debug(" >>> dotted // textWidth: " + textWidth + " multiline? " + multiline);
				if(multiline)
				{
					log.debug(" >>> " + scrollV + " of " + maxScrollV + " restrcit to: " + _maxLines);
					if(_maxLines != -1)
					{
						short = txt;
						if(maxScrollV > _maxLines)
						{
							super.htmlText = short + "...";	// "\u20DB"
							
							while(maxScrollV > _maxLines)
							{
								pos = short.lastIndexOf(" ");
								pos = (pos == -1) ? short.length-1 : pos;
								short = short.substr(0, pos);
								super.htmlText = short + "...";
								//log.debug(" >>> dotted // textWidth: " + textWidth);
							}
						}
					}
					else
					{
						// TODO: xxx 
					}
				}
				else
				{
					if(!(textWidth < width))
					{
						short = txt;
						super.htmlText = short + "...";	// "\u20DB"
						while(textWidth > width - 1)
						{
							pos = short.lastIndexOf(" ");
							pos = (pos == -1) ? short.length-1 : pos;
							short = short.substr(0, pos);
							super.htmlText = short + "...";
							//log.debug(" >>> dotted // textWidth: " + textWidth);
						}
					}
				}
			}
		}
	}
}
