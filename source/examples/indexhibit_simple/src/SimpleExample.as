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
package com.apdevblog.examples.indexhibit 
{
	import com.apdevblog.amf.RemoteGateway;
	import com.apdevblog.events.amf.ServiceEvent;
	import com.apdevblog.examples.indexhibit.model.vo.ExhibitVo;
	import com.apdevblog.examples.indexhibit.model.vo.ImageVo;
	import com.apdevblog.examples.indexhibit.ui.Exhibit;
	import com.apdevblog.utils.StringUtils;

	import flash.display.Sprite;
	import flash.net.registerClassAlias;
	import flash.text.TextField;

	/**
	 * Base class for the simple Flash / Indexhibit example.
	 *
	 * @playerversion Flash 9
 	 * @langversion 3.0
	 *
	 * @package    com.apdevblog.examples.indexhibit
	 * @author     Philipp Kyeck / phil[at]apdevblog.com
	 * @copyright  2009 apdevblog.com
	 * @version    0.1
	 */
	public class SimpleExample extends Sprite 
	{
		public static const SERVER_URL:String = "http://apdevblog.com/indexhibit/";
		public static const SERVICE_URL:String = "com.apdevblog.examples.indexhibit.Indexhibit";
		//
		public var preloader:Sprite;
		public var content:Sprite;
		public var logo:TextField;
		//
		private var _gateway:RemoteGateway;
		private var _exhibits:Array;

		/**
		 * 
		 */
		public function SimpleExample()
		{
			// we need to register these classes because the gateway will pass them to us
			// and they should automatically be mapped to the AS-classes
			registerClassAlias("com.apdevblog.examples.indexhibit.model.vo.ExhibitVo", ExhibitVo);
			registerClassAlias("com.apdevblog.examples.indexhibit.model.vo.ImageVo", ImageVo);
			
			// create gateway connection
			_createIndexhibitGateway();
			
			// get all exhibits
			_getAllExhibits();
		}
		
		private function _createIndexhibitGateway():void
		{
			_gateway = new RemoteGateway(SERVER_URL + "amf/gateway.php");
			_gateway.addEventListener(ServiceEvent.RESULT, onResultFromIndexhibit, false, 0, true);
		}

		private function _getAllExhibits():void
		{
			// call the service
			_gateway.call(SERVICE_URL, "getAllExhibits");
		}
		
		private function _init():void
		{
			// loading done - hide preloader
			removeChild(preloader);
			
			logo.mouseEnabled = false;
			
			// start creating exhibit objects for every exhibit from the database
			for(var i:int=0;i<_exhibits.length;i++)
			{
				var vo:ExhibitVo = _exhibits[i] as ExhibitVo;
				if(vo != null && vo.url != "/")
				{
					var exht:Exhibit = new Exhibit();
					exht.headline.htmlText = vo.title;
					exht.details.htmlText = vo.content;
					
					exht.setImages(vo.images);
					
					// position them randomly on the stage		
					exht.x = Math.round(Math.random() * (990 - 200));
					exht.y = Math.round(80 + Math.random() * (600 - 180));
					
					// change exhibit's bg corresponding to the category
					exht.bg.gotoAndStop(vo.category);
					
					content.addChild(exht);
				}
			}
		}

		private function onResultFromIndexhibit(event:ServiceEvent):void
		{
			switch(event.call.absoluteServicePath)
			{
				case SERVICE_URL + ".getAllExhibits":
					trace("result :: getAllExhibits :: " + StringUtils.objectToString(event.result));
					_exhibits = event.result["exhibits"] as Array;
					_init();
				break;
			}
		}
	}
}
