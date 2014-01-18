package com.apdevblog.text.spelling 
{
	import flash.events.TimerEvent;

	import com.adobe.linguistics.spelling.SpellChecker;
	import com.adobe.linguistics.spelling.SpellingDictionary;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.Timer;

	/**
	 * ActionScript SpellChecker class for TextFields in Flash.
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.text.spelling
	 * @author     Philipp Kyeck / phil[at]apdevblog.com
	 * @copyright  2009 apdevblog.com
	 * @version    0.21
	 * 
	 * based on example from com.adobe.linguistics.spelling.SpellChecker
	 * (http://download.macromedia.com/pub/labs/squiggly/squiggly_p1_asdoc_092109.zip)
	 */
	public class ApdevSpellChecker 
	{
		public static const TEXT_GUTTER:int = 2;
		//
		private const _wordPattern:RegExp = /\b\w+\b/;
		//
		private var _txt:TextField;
		private var _url:String;
		private var _canvas:Shape;
		private var _checker:SpellChecker;
		private var _dict:SpellingDictionary;
		private var _bmpData:BitmapData;
		private var _context:ContextMenu;
		private var _replaceOffsetBegin:int;
		private var _replaceOffsetEnd:int;
		private var _textScrollTimer:Timer;
		private var _visibleLines:int;

		/**
		 * 
		 */
		public function ApdevSpellChecker(txt:TextField, dictUrl:String = "")
		{
			_init(txt, dictUrl);
		}

		private function _init(txt:TextField, dictUrl:String):void
		{
			_txt = txt;
			_url = dictUrl;
			
			// ho wmany lines are shown
			var metrics:TextLineMetrics = _txt.getLineMetrics(0);
			var lineHeight:Number = metrics.ascent + metrics.descent + metrics.leading;
            
			_visibleLines = Math.floor(_txt.height / lineHeight);
            
			_bmpData = new BitmapData(2, 1, true, 0xFFFFFFFF);
			_bmpData.setPixel32(0, 0, 0xFFFF0000);
			_bmpData.setPixel32(1, 0, 0x00000000);
			
			// context menu
			_context = new ContextMenu();
			_context.hideBuiltInItems();
			_context.addEventListener(ContextMenuEvent.MENU_SELECT, onContextMenuSelect, false, 0, true);
			
			_txt.contextMenu = _context;
			
			// add spell checking
			_checker = new SpellChecker();
			_dict = new SpellingDictionary();
			_dict.addEventListener(Event.COMPLETE, onDictionaryLoaded, false, 0, true);
			
			// timer for scrolling text and checking afterwards
			_textScrollTimer = new Timer(40, 1);
			_textScrollTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onScrollCheckTimerComplete, false, 0, true);
			
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
			
			var inputValue:String = _txt.text;
			var offset:int, curPos:int;
  
			var startOffset:Number = _txt.getLineOffset(_txt.scrollV - 1);
			
			var maxLines:int = _txt.scrollV + _visibleLines;
			var endOffset:Number = 0; 
			var delta:Number = 0;
			if(maxLines < _txt.numLines)
			{
				endOffset = _txt.getLineOffset(maxLines - 1);
				delta = _txt.text.length - endOffset;
				endOffset = endOffset - startOffset;
				
				inputValue = inputValue.substr(startOffset, endOffset);
			}
			else
			{
				inputValue = inputValue.substr(startOffset);
			}
			
			var found:Boolean = true;
			var res:Array;
            
			while(found) 
			{
				// lookup word by word....
				res = inputValue.match(_wordPattern);
                
				if(res == null)
				{
					found = false;
				}
				else 
				{
					curPos = inputValue.indexOf(res[0]);
					if(!_checker.checkWord(res[0])) 
					{
						offset = (_txt.text.length - delta) - inputValue.length;
						_drawErrorHighlight(offset + curPos, offset + curPos + (res[0].length - 1));
					}
					inputValue = inputValue.substr(curPos + res[0].length);
				}
			}
		}

		private function _drawErrorHighlight(beginIndex:int,endIndex:int):void 
		{
			if(endIndex < beginIndex) 
			{ 
				return; 
			}
			
			--beginIndex;
			
			var rect1:Rectangle;
			while(rect1 == null && beginIndex + 1 < endIndex)
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
			while(rect2 == null && endIndex - 1 > beginIndex)
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
		
		private function _getSuggestions(word:String):void
		{
			if(!_checker.checkWord(word)) 
			{
				var suggestions:Array = _checker.getSuggestions(word);
				var len:int = suggestions.length;
				var items:Array = [];
				
				for(var i:int = 0;i < len;i++)
				{
					var word:String = suggestions[i];
					if(word != null && word != "")
					{
						var menuItem:ContextMenuItem = new ContextMenuItem(word); 
						menuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onContextMenuItemSelect, false, 0, true);
						items.push(menuItem);
					}
				}
				
				if(items.length == 0)
				{ 
					items.push(new ContextMenuItem("No suggestions found", false, false));
				}
				
				_context.customItems = items;
			}
		}

		private function onContextMenuSelect(event:ContextMenuEvent):void
		{
			var index:int = _txt.getCharIndexAtPoint(_txt.mouseX, _txt.mouseY);
			_context.customItems = [];
			
			var inputValue:String = _txt.text;
			var offset:int, curPos:int;
            
			var found:Boolean = true;
			var res:Array;
            
			var begin:int = inputValue.lastIndexOf(" ", index);
			if(begin >= 0)
			{
				inputValue = inputValue.substr(begin + 1);
			}
            
			while(found) 
			{
				// lookup word by word....
				res = inputValue.match(_wordPattern);
                
				if(res == null)
				{
					found = false;
				}
				else 
				{
					curPos = inputValue.indexOf(res[0]);
					offset = _txt.text.length - inputValue.length;
					inputValue = inputValue.substr(curPos + res[0].length);
	                
					if(offset <= index && index <= (offset + res[0].length))
					{
						_getSuggestions(res[0]);
						
		                _replaceOffsetBegin = offset;
						_replaceOffsetEnd = offset + res[0].length;
						found = false;
					}
				}
			}
		}

		private function onContextMenuItemSelect(event:ContextMenuEvent):void
		{
			var item:ContextMenuItem = event.target as ContextMenuItem;
			if(item != null)
			{
				_txt.replaceText(_replaceOffsetBegin, _replaceOffsetEnd, item.caption);
				
				var caretPosition:Number = _replaceOffsetBegin + item.caption.length;
				_txt.setSelection(caretPosition, caretPosition);
				
				_checkText();
			}
		}
		
		private function onDictionaryLoaded(event:Event):void
		{
			_checker.addDictionary(_dict);
			
			if(_canvas != null)
			{
				_checkText();
			}
		}

		private function onScrollCheckTimerComplete(event:TimerEvent):void
		{
			_checkText();
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
				// clear old error highlights
				_canvas.graphics.clear();
				
				_textScrollTimer.reset();
				_textScrollTimer.start();
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
