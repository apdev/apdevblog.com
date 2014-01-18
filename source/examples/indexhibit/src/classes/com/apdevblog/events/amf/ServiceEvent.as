package com.apdevblog.events.amf 
{
	import com.apdevblog.amf.RemoteCall;

	import flash.events.Event;

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
	public class ServiceEvent extends Event
	{
		/** The type of the event */
		public static const RESULT:String = "onServiceResult";
		public static const FAULT:String = "onServiceFault";
		public static const ERROR:String = "onServiceError";
		
		/** The remote service call */
		private var _call:RemoteCall;
		
		/** The result of the remote service call */
		private var _result:Object;

		/**
		* The ServiceResult constructor.
		*
		* @param call The RemoteCall returning the result
		* @param result The result received
		*
		* @exclude
		*/
		public function ServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, call:RemoteCall=null, result:Object=null)
		{
			super(type, bubbles, cancelable);
			_call = call;
			_result = result;
		}
		
		/**
		 * public methods
		 */
		public override function clone():Event
		{
			return new ServiceEvent(type, bubbles, cancelable, _call, _result);
		}
		
		public override function toString():String
		{
			return formatToString("ServiceResult", "type", "bubbles", "cancelable", "eventPhase", "call", "result");
		}
		
		/**
		 * getter / setter
		 */
		public function get backendstatus():String
		{
			var status:String;
			try
			{
				status = _result["backendstatus"];
			}
			catch(err1:Error)
			{
				try
				{
					status = data["backendstatus"];
				}
				catch(err2:Error)
				{
					status = "ok";
				}
			}
			
			if(status == null)
			{
				try
				{
					status = data["backendstatus"];
				}
				catch(err3:Error)
				{
					status = "unknown";
				}
			}
			
			return status;
		}

		public function get call():RemoteCall
		{
			return _call;
		}

		public function get data():Object
		{
			return _result["data"];
		}
		
		public function get errorMsg():String
		{
			var error:String;
			try
			{
				error = data["errorMsg"];
			}
			catch(err:Error)
			{
				try
				{
					error = _result["errorMsg"];
				}
				catch(err2:Error)
				{
					error = "unknown";
				}
			}
			return error;
		}
		
		public function get result():Object
		{
			return _result;
		}
	}
}
