package com.apdevblog.examples.indexhibit.view.content 
{
	
	import gs.TweenLite;
	import gs.easing.Quart;

	import com.apdevblog.examples.indexhibit.model.Constants;
	import com.apdevblog.examples.indexhibit.model.vo.ExhibitVo;
	import com.apdevblog.examples.indexhibit.model.vo.ImageVo;
	import com.apdevblog.examples.indexhibit.view.ui.CTextField;
	import com.apdevblog.utils.Draw;
	import com.quasimondo.geom.ColorMatrix;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.getQualifiedClassName;

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
	public class ContentDetail extends Sprite 
	{
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(ContentDetail));
		//
		private var _vo:ExhibitVo;
		private var _label:CTextField;
		private var _copy:CTextField;
		private var _image:Loader;
		private var _imageMask:Shape;
		private var _cross:Cross;
		private var _imageContainer:Sprite;
		private var _bitmap:Bitmap;
		private var _bmpData:BitmapData;
		private var _imageNavi:Sprite;
		private var _highlight:Sprite;

		public function ContentDetail()
		{
			_init();
		}
		
		public function close():void
		{
			_resetImages();
		}
		
		private function _resetImages():void
		{
			_image.unload();
			
			_image.x = 0;
			_image.y = 0;
			
			_image.scaleX = 1;
			_image.scaleY = 1;
			
			if(_bmpData != null)
			{
				_bmpData.dispose();
				_bmpData = null;
			}
			
			if(_bitmap != null)
			{
				_imageContainer.removeChild(_bitmap);
				_bitmap = null;
			}
		}

		public function setData(vo:ExhibitVo):void
		{
			_vo = vo;
			
			_label.htmlText = "<u>" + _vo.title.toLowerCase() + "</u>";
			
			_cross.x = Math.round(_label.x + _label.textWidth) + 12;
			
			_imageNavi.y = Math.round(_label.y + _label.height + 8);
			
			// clear
			while(_imageNavi.numChildren > 0)
			{
				var diso:DisplayObject = _imageNavi.getChildAt(0);
				_imageNavi.removeChild(diso);
				diso = null;
			}
			
			if(_vo.images != null)
			{
				var curx:int = 0;
				var cury:int = 0;
				
				_highlight = new Sprite();
				_highlight.addChild(Draw.rect(30, 20, 0x000000, 1));
				_highlight.addChild(Draw.rect(28, 18, 0xFFFFFF, 1, 1, 1));
				_imageNavi.addChild(_highlight);
				
				for(var i:int=0;i<_vo.images.length;i++)
				{
					var img:ImageVo = _vo.images[i] as ImageVo;
					if(img != null)
					{
						// image navigation
						var btn:Sprite = new Sprite();
						btn.x = curx;
						btn.y = cury;
						btn.buttonMode = true;
						btn.mouseChildren = false;
						btn.name = Constants.SERVER_URL + "ndxz/files/gimgs/th-" + img.file;
						btn.addEventListener(MouseEvent.CLICK, onClickImageNavigation, false, 0, true);
						btn.addChild(Draw.rect(30, 20, 0x000000, 1));
						_imageNavi.addChildAt(btn, 0);
						
						curx += 33;
						if(curx >= 250)
						{
							curx = 0;
							cury += 23;
						}
						
						if(i == 0)
						{
							_loadImage(btn.name);
						}
					}
				}
			}
			
			_copy.y = Math.round(_imageNavi.y + _imageNavi.height + 18);
			
			_copy.htmlText = _vo.content;
		}
		
		private function onClickImageNavigation(event:MouseEvent):void
		{
			log.debug("onClickImageNavigation() >>> " + event.target.x);
			_loadImage(event.target.name);
			
			TweenLite.to(_highlight, 0.2, {x:event.target.x});
		}

		private function _loadImage(imageUrl:String):void
		{
			_resetImages();
			
			var req:URLRequest = new URLRequest(imageUrl);
			var context:LoaderContext = new LoaderContext(true);					
			_image.load(req, context);
		}
		
		private function onImageLoadError(event:IOErrorEvent):void
		{
		}

		private function _draw():void
		{
			_imageContainer = new Sprite();
			_imageContainer.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			_imageContainer.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
			addChild(_imageContainer);
			
			_image = new Loader();
			_image.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete, false, 0, true);
			_image.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageLoadError, false, 0, true);
			_imageContainer.addChild(_image);
			
			_imageMask = Draw.rect(545, 320, 0xFF0000, 1);
			addChild(_imageMask);
			
			_imageContainer.mask = _imageMask;
			
			_label = new CTextField(CTextField.DETAILS_TITLE, "", 600, -6, 300, 22);		// y:5
			addChild(_label);
			
			_cross = new Cross();
			_cross.x = Math.round(_label.x + _label.textWidth) + 18;
			_cross.y = 1;
			addChild(_cross);
			
			// image navigation container
			_imageNavi = new Sprite();
			_imageNavi.x = 602;
			_imageNavi.y = 40;
			addChild(_imageNavi);
			
			_copy = new CTextField(CTextField.DETAILS_COPY, "", 600, 70, 300, 22);	// y: 42
			addChild(_copy);
		}
		
		private function onLoadComplete(event:Event):void
		{
			log.debug("onLoadComplete()");
			
			_bmpData = new BitmapData(_image.width, _image.height, true, 0xFF000000);
			_bmpData.draw(_image);
			
			////////////////////////////////////////
			var mat:ColorMatrix = new ColorMatrix();
			
			var brightness:Number = 0;
			var contrast:Number = 50;	// 100
			var hue:Number = 0;
			var saturation:Number = 0;
			var alpha:Number = 100;
			
			mat.adjustHue(hue);
			mat.adjustSaturation(saturation/100);
			mat.adjustContrast(contrast/100);
			mat.adjustBrightness(255*brightness/100);
			mat.setAlpha(alpha/100);
		
			var grids:Array = [];
			grids.push(		[	0, 0, 0, 0,		0, 1, 0, 0,		0, 0, 1, 0,		0, 0, 0, 1	]	);
			grids.push(		[	1, 0, 0, 0,		0, 0, 0, 0,		0, 0, 1, 0,		0, 0, 0, 1	]	);
			grids.push(		[	1, 0, 0, 0,		0, 1, 0, 0,		0, 0, 0, 0,		0, 0, 0, 1	]	);
			grids.push(		[	1, 0, 0, 0,		0, 1, 0, 0,		0, 0, 1, 0,		0, 0, 0, 1	]	);
			
//			var rdm:int = Math.random()*grids.length;
//			var rdm:int = _getImageColor(_vo.category);
			var rdm:int = 3; 
			
			var cr:Number = (grids[rdm][0] == 1 ? 1:0) | (grids[rdm][1] == 1 ? 2:0) | (grids[rdm][2] == 1 ? 4:0) | (grids[rdm][3] == 1 ? 8:0);
			var cg:Number = (grids[rdm][4] == 1 ? 1:0) | (grids[rdm][5] == 1 ? 2:0) | (grids[rdm][6] == 1 ? 4:0) | (grids[rdm][7] == 1 ? 8:0);
			var cb:Number = (grids[rdm][8] == 1 ? 1:0) | (grids[rdm][9] == 1 ? 2:0) | (grids[rdm][10] == 1 ? 4:0) | (grids[rdm][11] == 1 ? 8:0);
			var ca:Number = (grids[rdm][12] == 1 ? 1:0) | (grids[rdm][13] == 1 ? 2:0) | (grids[rdm][14] == 1 ? 4:0) | (grids[rdm][15] == 1 ? 8:0);
			
			mat.setChannels(cr,cg,cb,ca);
			
			var cm:ColorMatrixFilter = new ColorMatrixFilter(mat.matrix);
			_bmpData.applyFilter(_bmpData, _bmpData.rect, new Point(0,0), cm);
			////////////////////////////////////////
			
			_bitmap = new Bitmap(_bmpData, "auto", true);
			
			_image.alpha = 0;
			_image.visible = false;
			
			var maskRatio:Number = _imageMask.width/_imageMask.height;
			var imgRatio:Number = _bitmap.width/_bitmap.height;
			if(maskRatio >= imgRatio)
			{
				_bitmap.width = _imageMask.width;
				_bitmap.height = _bitmap.width/imgRatio;

				_bitmap.x = 0;
				_bitmap.y = 0;
			}
			else
			{
				_bitmap.height = _imageMask.height;
				_bitmap.width = _bitmap.height*imgRatio;

				_bitmap.y = 0;
				_bitmap.x = Math.round((_imageMask.width - _bitmap.width) * 0.5);
			}
			
			_image.x = _bitmap.x;
			_image.y = _bitmap.y;
			
			_image.width = _bitmap.width;
			_image.height = _bitmap.height;
			
			_imageContainer.addChildAt(_bitmap, 0);
			
			_bitmap.alpha = 0;
			
			TweenLite.to(_bitmap, 0.6, {alpha:1, ease:Quart.easeOut});
		}

		private function _init():void
		{
			_draw();
			
			_cross.addEventListener(MouseEvent.CLICK, onClickClose, false, 0, true);
			
		}
		
		private function onMouseOut(event:MouseEvent):void
		{
			TweenLite.to(_image, 0.8, {autoAlpha:0, ease:Quart.easeOut});
		}

		private function onMouseOver(event:MouseEvent):void
		{
			TweenLite.to(_image, 0.8, {autoAlpha:1, ease:Quart.easeOut});
		}
		
		private function onClickClose(event:MouseEvent):void
		{
			if(event.cancelable)
			{
				event.stopImmediatePropagation();
			}
			
			dispatchEvent(new Event(Event.CLOSE, true, true));
		}
	}
}
