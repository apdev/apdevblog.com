/**
 * Copyright (c) 2009 apdevblog.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.apdevblog.examples.indexhibit.ui 
{
	import com.apdevblog.examples.indexhibit.SimpleExample;
	import com.apdevblog.examples.indexhibit.model.vo.ImageVo;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;

	/**
	 * Class to extend the functionality of the timeline based
	 * exhibit movieclip in the FLA's library.
	 * 
	 * @playerversion Flash 9
 	 * @langversion 3.0
	 *
	 * @package    com.apdevblog.examples.indexhibit.ui
	 * @author     Philipp Kyeck / phil[at]apdevblog.com
	 * @copyright  2009 apdevblog.com
	 * @version    0.1
	 */
	public class Exhibit extends MovieClip 
	{
		public var headline:TextField;
		public var details:TextField;
		public var bg:MovieClip;
		public var drag:SimpleButton;
		public var details_btn:SimpleButton;
		public var detailsClose_btn:SimpleButton;
		public var maskContent:MovieClip;
		//
		public var img0:MovieClip;
		public var img1:MovieClip;
		public var img2:MovieClip;
		public var img3:MovieClip;
		
		/**
		 * 
		 */
		public function Exhibit()
		{
			// stop mc from playing any further
			stop();
			
			// add listener
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			details_btn.addEventListener(MouseEvent.CLICK, onOpenDetails, false, 0, true);
			
			// add dropshadow
			filters = [new DropShadowFilter(4, 45, 0x000000, 1, 12, 12, 0.15)];
		}
		
		public function setImages(images:Array):void
		{
			if(images == null)
			{
				return;
			}
			
			var len:int = Math.min(images.length, 4);
			for(var i:int=0;i<len;i++)
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImgLoaded, false, 0, true);
				
				loader.addEventListener(MouseEvent.MOUSE_OVER, onImageOver, false, 0, true);
				loader.addEventListener(MouseEvent.MOUSE_OUT, onImageOut, false, 0, true);
				
				var imgContainer:MovieClip = this["img"+i];
				var img:ImageVo = images[i] as ImageVo;
				
				loader.load(new URLRequest(SimpleExample.SERVER_URL + "ndxz/files/gimgs/th-" + img.file));
				
				imgContainer.addChild(loader);
			}
		}
		
		private function onImageOut(event:MouseEvent):void
		{
			var image:Loader = event.target as Loader;
			if(image != null)
			{
				image.content.scaleX = image.content.scaleY = 0.25;
				
				img0.visible = true;
				img0.x = 210;
				img0.y = 122;
				
				img1.visible = true;
				img1.x = 360;
				img1.y = 122;
				
				img2.visible = true;
				img2.x = 210;
				img2.y = 212;
				
				img3.visible = true;
				img3.x = 360;
				img3.y = 212;
			}
		}

		private function onImageOver(event:MouseEvent):void
		{
			var image:Loader = event.target as Loader;
			if(image != null)
			{
				img0.visible = false;
				img1.visible = false;
				img2.visible = false;
				img3.visible = false;
				
				image.parent.visible = true;
				image.parent.x = 210;
				image.parent.y = 122;
				
				image.content.scaleX = image.content.scaleY = 1.0;
			}
		}
		
		private function onImgLoaded(event:Event):void
		{
			var loader:LoaderInfo = event.target as LoaderInfo;
			if(loader != null)
			{
				loader.content.scaleX = loader.content.scaleY = 0.25;
			}
		}

		private function onMouseDown(event:MouseEvent):void
		{
			if(drag == event.target)
			{
				startDrag();
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			}
			
			parent.setChildIndex(this, parent.numChildren-1);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stopDrag();
			
			x = Math.round(x);
			y = Math.round(y);
		}
		
		private function onOpenDetails(event:MouseEvent):void
		{
			gotoAndPlay("open");
			details_btn.removeEventListener(MouseEvent.CLICK, onOpenDetails);
			detailsClose_btn.addEventListener(MouseEvent.CLICK, onCloseDetails, false, 0, true);
		}
		
		private function onCloseDetails(event:MouseEvent):void
		{
			gotoAndPlay("close");
			details_btn.addEventListener(MouseEvent.CLICK, onOpenDetails, false, 0, true);
			detailsClose_btn.removeEventListener(MouseEvent.CLICK, onCloseDetails);
		}
	}
}
