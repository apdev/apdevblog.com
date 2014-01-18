package com.apdevblog.text.spelling 
{
	import com.adobe.linguistics.spelling.SpellChecker;
	import com.adobe.linguistics.spelling.SpellingDictionary;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;

	/**
	 * ActionScript SpellChecker class for TextFields in Flash.
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.text.spelling
	 * @author     Philipp Kyeck / phil[at]apdevblog.com
	 * @copyright  2009 apdevblog.com
	 * @version    0.1
	 * 
	 * based on example from com.adobe.linguistics.spelling.SpellChecker
	 * (http://download.macromedia.com/pub/labs/squiggly/squiggly_p1_asdoc_092109.zip)
	 */
	public class ApdevSpellChecker 
	{
		public static const TEXT_GUTTER:int = 2; 
		//
		private var _txt:TextField;
		private var _url:String;
		private var _canvas:Shape;
		private var _checker:SpellChecker;
		private var _dict:SpellingDictionary;
		private var _bmpData:BitmapData;

		/**
		 * 
		 */
		public function ApdevSpellChecker(txt:TextField, dictUrl:String="")
		{
			_init(txt, dictUrl);
		}
		
		private function _init(txt:TextField, dictUrl:String):void
		{
			_txt = txt;
			_url = dictUrl;
			
			_bmpData = new BitmapData(2, 1, true, 0xFFFFFFFF);
			_bmpData.setPixel32(0, 0, 0xFFFF0000);
			_bmpData.setPixel32(1, 0, 0x00000000);
			
			// add spell checking
			_checker = new SpellChecker();
			_dict = new SpellingDictionary();
			
			if(_txt.parent == null)
			{
				_txt.addEventListener(Event.ADDED_TO_STAGE, onTxtAddedToStage, false, 0, true);
			}
			else
			{
				_addCanvas();
			}
			
			if(dictUrl != "")
			{
				loadDictionary(dictUrl);
			}
		}
		
		private function loadDictionary(dictUrl:String):void
		{
			if(dictUrl == "")
			{
				return;
			}
			
			_dict.load(new URLRequest(dictUrl));
			
			_txt.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}

		private function _addCanvas():void
		{
			_canvas = new Shape();
			_canvas.x = _txt.x;
			_canvas.y = _txt.y;
			
			_txt.parent.addChildAt(_canvas, _txt.parent.getChildIndex(_txt));
			
			_txt.addEventListener(Event.CHANGE, onTextChanged, false, 0, true);
			_txt.addEventListener(Event.SCROLL, onTextScroll, false, 0, true);
			
			if(_dict.loaded)
			{
				_checkText();
			}
		}
		
		private function _checkText():void 
		{
			_canvas.graphics.clear();
			
			// regex for matching next word...
            var wordPattern:RegExp = /\b\w+\b/;
           
            var inputValue:String = _txt.text;
            var offset:int, curPos:int;
            
            var found:Boolean = true;
            var res:Array;
            
            while(found) 
            {
            	// lookup word by word....
                res = inputValue.match(wordPattern);
                
                if(res == null)
                {
                	found = false;
                }
                else 
                {
                    curPos = inputValue.indexOf(res[0]);
                	if(!_checker.checkWord(res[0])) 
	                {
	                    offset = _txt.text.length - inputValue.length;
	                    drawErrorHighlight(offset + curPos, offset + curPos + (res[0].length-1));
	                }
	                inputValue = inputValue.substr(curPos + res[0].length);
                }
            }
        }
		
		public function drawErrorHighlight(beginIndex:int,endIndex:int):void 
		{
			if(endIndex < beginIndex) 
			{ 
				return; 
			}
			
			--beginIndex;
			
			var rect1:Rectangle;
			while(rect1 == null && beginIndex+1 < endIndex)
			{
				rect1 = _txt.getCharBoundaries(++beginIndex);
			}
			
			// cannot find boundaries => letter is not displayed
			if(rect1 == null) 
			{
//				trace("No CharBoundaries for 1 beginIndex=" + beginIndex + " endIndex=" + endIndex + " [" + _txt.text.substring(beginIndex, endIndex) + "]");
				return;
			}
			
			++endIndex;
			
			var rect2:Rectangle;
			while(rect2 == null && endIndex-1 > beginIndex)
			{
				rect2 = _txt.getCharBoundaries(--endIndex);
			}
			
			// cannot find boundaries => letter is not displayed
			if(rect2 == null) 
			{
//				trace("No CharBoundaries for 2 beginIndex=" + beginIndex + " endIndex=" + endIndex + " [" + _txt.text.substring(beginIndex, endIndex) + "]");
				return;
			}
			
			
			// if line isn't rendered, do highlight error
			var lineNum:int = _txt.getLineIndexOfChar(beginIndex);
			if(lineNum >= _txt.bottomScrollV)
			{
				return;
			}
			
			// reposition canvas
			var metrics:TextLineMetrics = _txt.getLineMetrics(lineNum);
			var lineHeight:Number = metrics.ascent + metrics.descent + metrics.leading;
			_canvas.y = _txt.y - (_txt.scrollV - 1) * lineHeight;
			
			// get vals for drawing highlight
			var x1:int = rect1.x;
			var x2:int = rect2.x + rect2.width;
			var y1:int = rect1.y + metrics.ascent + 2;
			var w:Number = x2 - x1;
			
			if(w > 0) 
			{
				_canvas.graphics.beginBitmapFill(_bmpData);
				_canvas.graphics.drawRect(x1, y1, w, 1);
				_canvas.graphics.endFill();
			}
		}
		
		private function onEnterFrame(event:Event):void
		{
			trace("dict >>> loaded? " + _dict.loaded);
			if(_dict.loaded)
			{
				_txt.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				_checker.addDictionary(_dict);
				
				if(_canvas != null)
				{
					_checkText();
				}
			}
		}
		
		private function onTxtAddedToStage(event:Event):void
		{
			_txt.removeEventListener(Event.ADDED_TO_STAGE, onTxtAddedToStage);
			_addCanvas();
		}
		
		private function onTextScroll(event:Event):void
		{
			if(_dict.loaded)
			{
				_checkText();
			}
		}

		private function onTextChanged(event:Event):void
		{
			if(_dict.loaded)
			{
				_checkText();
			}
		}
	}
}
