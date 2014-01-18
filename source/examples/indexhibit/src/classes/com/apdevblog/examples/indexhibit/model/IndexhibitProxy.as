package com.apdevblog.examples.indexhibit.model 
{
	
	import com.apdevblog.amf.RemoteGateway;
	import com.apdevblog.events.amf.ServiceEvent;
	import com.apdevblog.examples.indexhibit.model.vo.ExhibitVo;
	import com.apdevblog.utils.StringUtils;
	import com.asual.SWFAddress;
	import com.asual.events.SWFAddressEvent;

	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.utils.getQualifiedClassName;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.model
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: IndexhibitProxy.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class IndexhibitProxy extends Proxy 
	{
		public static const NAME:String = "IndexhibitProxy";
		//
		public static const CHANGE_PAGE:String = "IndexhibitProxyChangePage";
		public static const PAGE_CHANGED:String = "IndexhibitProxyPageChanged";
		public static const SELECT_PAGE:String = "IndexhibitProxySelectPage";
		public static const UPDATE_TITLE:String = "IndexhibitProxyUpdateTitle";
		//
		public static const EXHIBITS_CHANGED:String = "IndexhibitProxyExhibitsChanged";
		//
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(IndexhibitProxy));
		//
		private static const serviceUrl:String = "com.apdevblog.examples.indexhibit.Indexhibit";
		//
		private var _gateway:RemoteGateway;
		
		/**
		 * 
		 */
		public function IndexhibitProxy()
		{
			super(IndexhibitProxy.NAME, {});
		}
		
		public function getAllExhibits():void
		{
			_gateway.call(IndexhibitProxy.serviceUrl, "getAllExhibits");
		}
		
		private function _init():void
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onUrlChange, false, 0, true);
		}
		
		override public function onRegister():void
		{
			//_serv = ServiceLocator.getInstance();
			_gateway = new RemoteGateway(Constants.SERVER_URL + "amf/gateway.php");
			
			// add event listener
			_gateway.addEventListener(ServiceEvent.RESULT, onResult, false, 0, true);
		}
		
		private function onResult(event:ServiceEvent):void
		{
			switch(event.call.absoluteServicePath)
			{
				case IndexhibitProxy.serviceUrl + ".getAllExhibits":
					log.debug("result :: getAllExhibits :: " + StringUtils.objectToString(event.result));
					exhibits = event.result["exhibits"];
					_init();
				break;
			}
		}
		
		private function onUrlChange(event:SWFAddressEvent):void
		{
			log.debug("onUrlChange() >>> " + event.path);
			
			currentUrl = event.path;
		}
		
		public function get currentUrl():String
		{
			return data["currentUrl"] as String;
		}
		
		public function set currentUrl(url:String):void
		{
			log.debug("set currentUrl() >>> " + url + " alt: " + data["currentUrl"]);
			
			if(url == data["currentUrl"])
			{
				// same url exit
				return;
			}
			
			// look for exhibit
			var exh:ExhibitVo;
			for(var i:int=0;i<exhibits.length;i++)
			{
				exh = exhibits[i] as ExhibitVo;
				if(exh != null)
				{
					log.debug("page.url: " + exh.url);
					if(exh.url == url)
					{
						data["currentUrl"] = exh.url;
						sendNotification(IndexhibitProxy.PAGE_CHANGED, exh);
						sendNotification(IndexhibitProxy.UPDATE_TITLE, exh);
						
						return;
					}
				}
			}
			
			sendNotification(IndexhibitProxy.SELECT_PAGE, "/");
		}
		
		public function get exhibits():Array
		{
			return data["exhibits"];
		}
		
		public function set exhibits(exhibits:Array):void
		{
			log.debug("set exhibits()");
			data["exhibits"] = exhibits;
			
			sendNotification(IndexhibitProxy.EXHIBITS_CHANGED, exhibits);
		}
	}
}
