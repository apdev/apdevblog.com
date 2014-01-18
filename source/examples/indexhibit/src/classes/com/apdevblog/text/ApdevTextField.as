package com.apdevblog.text 
{
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	/**
	 * Our custom textfield.
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.text
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2008 beta_interactive
	 * @version    SVN: $Id: VTextField.as 281 2009-04-22 16:09:39Z phil $
	 */
	public class ApdevTextField extends TextField 
	{
		public static const DEFAULT_WIDTH:int = 20;
		public static const DEFAULT_HEIGHT:int = 10;
		//
		public static const DEFAULT_STYLE:String = "defaultStyle";
		public static const DEFAULT_MULTILINE_STYLE:String = "defaultMultilineStyle";
		public static const DEFAULT_INPUT:String = "defaultInput";
		public static const DEFAULT_BUTTON:String = "defaultButton";
		//
		protected var _originalText:String;
		protected var _originalWidth:int;
		protected var _originalHeight:int;

		/**
		 * constructor.
		 */
		public function ApdevTextField(	style:String, 
									label:String = "", 
									x:int = 0, 
									y:int = 0, 
									width:int = 0, 
									height:int = 0
									)
		{
			_init(style, label, x, y, width, height);
		}
		
		public function move(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 * init textfield.
		 */
		protected function _init(	style:String, 
									label:String, 
									x:int, 
									y:int, 
									tf_width:int, 
									tf_height:int
									):void
		{
			mouseEnabled = false;
			mouseWheelEnabled = false;
			antiAliasType = AntiAliasType.ADVANCED;
			
			var styles:Array = _setStyle(style);		
			defaultTextFormat = styles[0];
			if(type != TextFieldType.INPUT)
			{
				if(styles[1] != null) styleSheet = styles[1];
			}
			
			_originalWidth = (tf_width != 0) ? tf_width : ApdevTextField.DEFAULT_WIDTH; 
			_originalHeight = (tf_height != 0) ? tf_height : ApdevTextField.DEFAULT_HEIGHT; 
			
			width = _originalWidth;
			height = _originalHeight;
			
			htmlText = label != null ? label : "";
			
			this.x = x;
			this.y = y;
		}
		
		protected function _setStyle(style:String):Array
		{
			var tf:ApdevTextFormat = new ApdevTextFormat();
			var styles:StyleSheet;
			
			switch(style) 
			{
				case ApdevTextField.DEFAULT_INPUT:
					tf.font = "_sans";
					tf.size = 11;
					tf.color = 0x000000;
					
					type = TextFieldType.INPUT;
					border = true;
					mouseEnabled = true;
					background = true;
					backgroundColor = 0xFFFFFF;
					break;

				case ApdevTextField.DEFAULT_BUTTON:
					tf.font = "_sans";
					tf.size = 11;
					tf.color = 0x000000;
					
					autoSize = TextFieldAutoSize.NONE;
					break;
					
				case ApdevTextField.DEFAULT_MULTILINE_STYLE:
					multiline = true;
					wordWrap = true;
					
				case ApdevTextField.DEFAULT_STYLE:
				default:
					tf.font = "_sans";
					tf.size = 11;
					tf.color = 0xFF0000;
					
					autoSize = TextFieldAutoSize.LEFT;
					break;
			}
			
			return [tf, styles];
		}
		
		public function get align():String
		{
			var fmt:TextFormat = this.getTextFormat();
			return fmt.align;
		}

		public function set align(newAlign:String):void
		{
			var fmt:TextFormat = this.getTextFormat();
			fmt.align = newAlign;
			this.setTextFormat(fmt);
		}
		
		public override function set htmlText(txt:String):void
		{
			_originalText = txt;
			super.htmlText = txt;
		}
		
		public function get originalText():String
		{
			return _originalText;
		} 
	}
}
