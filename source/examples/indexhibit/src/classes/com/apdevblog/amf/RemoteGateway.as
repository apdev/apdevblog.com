package com.apdevblog.amf 
{
	import com.apdevblog.events.amf.ServiceEvent;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Responder;
	import flash.utils.getQualifiedClassName;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.amf
	 * @author     phil / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id$
	 */
	public class RemoteGateway extends Responder implements IEventDispatcher
	{
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(RemoteGateway));
		//
		private var _dispatcher:EventDispatcher;
		private var _connection:RemoteConnection;
		//
		private var _gatewayUrl:String;
		private var _serviceName:String;
		private var _methodName:String;
		private var _params:Array;

		public function RemoteGateway(gatewayUrl:String)
		{
			super(onResult, onFault);
			_gatewayUrl = gatewayUrl;
			_dispatcher = new EventDispatcher();			
		}
		
		public function call(service:String, method:String, params:Array=null):void
		{
			log.debug("call("+service+","+method+","+params+")");
			
			if(params == null)
			{
				params = [];
			}
			
			_serviceName = service;
			_methodName = method;
			_params = params;
			
			_connection = new RemoteConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus, false, 0, true);
			_connection.addEventListener(IOErrorEvent.IO_ERROR, onConnectionError, false, 0, true);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR , onSecurityError, false, 0, true);
            _connection.connect(_gatewayUrl);

            var callParams:Array = [_serviceName+"."+_methodName];
            callParams.push(this);
            callParams = callParams.concat(params);

            log.debug("_connection.call("+_serviceName+"."+_methodName+") " + _connection);
            log.debug(" >>> callParams " + callParams);
			
			_connection.call.apply(null, callParams);
		}

		private function onConnectionError(event:IOErrorEvent):void
		{
			// throw new Error("Problems connectiong to remote gateway!");
			log.error("Problems connectiong to remote gateway!");
		}
		
		/*
		 * The method being invoked when the Service instance has received a result.
		 *
		 * @param evt The standard Object
		 */
		public function onResult(evt:Object):void
		{
			log.debug("onResult()");
			var call:RemoteCall = new RemoteCall(_serviceName, _methodName, _params);
			dispatchEvent(new ServiceEvent(ServiceEvent.RESULT, false, false, call, evt));
		}

		/*
		 * The method being invoked when the Service instance has received a fault.
		 *
		 * @param evt The standard Object
		 */
		public function onFault(evt:Object):void
		{
			log.debug("onFault()");
			var call:RemoteCall = new RemoteCall(_serviceName, _methodName, _params);
			dispatchEvent(new ServiceEvent(ServiceEvent.FAULT, false, false, call, evt));	// evt["fault"]
		}
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			log.debug("onNetStatus() " + e.info["code"] + " " + e.info["level"]);
			if(String(e.info["level"]).toLowerCase() == "error")
			{
				//throw new Error("Problems communicating with remote gateway!");
				log.error("Problems communicating with remote gateway!");
			}
		}

		private function onSecurityError(e:SecurityErrorEvent):void 
		{
			//log.debug("onSecurityError()");
			//throw new Error("Security problems communicating with remote gateway!");
			log.error("Security problems communicating with remote gateway!");
		}
		
		
		
		
		
		/**
		 * event dispatcher implementation
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}

		public function hasEventListener(type:String):Boolean
		{
			return _dispatcher.hasEventListener(type);
		}

		public function willTrigger(type:String):Boolean
		{
			return _dispatcher.willTrigger(type);
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}

		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
	}
}
