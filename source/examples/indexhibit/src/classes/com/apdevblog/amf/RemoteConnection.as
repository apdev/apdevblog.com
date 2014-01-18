package com.apdevblog.amf
{
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.utils.getQualifiedClassName;

	/**
	 * RemoteConnection - a child of NetConnection that adds methods to support 
	 * AppendToGatewayUrl, AddHeader, setCredentials and ReplaceGatewayUrl
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.amf
	 * @author     phil / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id$
	 */
	public class RemoteConnection extends NetConnection
	{
		private static const log:Logger = LogContext.getLogger(getQualifiedClassName(RemoteConnection));
		//
		
		/**
		 * 
		 */
		public function RemoteConnection(encoding:int=-1)
		{
			super();
			log.info("RemoteConnection()");
			objectEncoding = (encoding != -1) ? encoding : ObjectEncoding.AMF3;
		}
		
		/*
		 * AppendToGatewayUrl - AMF0
		 */
		public function AppendToGatewayUrl(s:String):void
		{
			log.info("AppendToGatewayUrl("+s+")");
		}
		
		/*
		 * AddHeader - add a persistent header. 
		 * After adding a header it get's sent with every request
		 */
		public function AddHeader(name:String, mustUnderstand:Boolean, value:Object ):void
		{
			log.info("AddHeader("+name+")");
			super.addHeader(name, mustUnderstand, value);
		}
		
		/*
		 * ReplaceGatewayUrl - Replace the current gateway url
		 */
		public function ReplaceGatewayUrl():void
		{
			log.info("ReplaceGatewayUrl()");
		}
		
		/*
		 * setCredentials - implements authentication
		 * @param username:String
		 * @param password:String
		 */
		public function setCredentials(username:String, password:String):void
		{
			log.info("setCredentials("+username+")");
			super.addHeader( "Credentials", false, { userid:username, password:password } );
		}
	}
}

