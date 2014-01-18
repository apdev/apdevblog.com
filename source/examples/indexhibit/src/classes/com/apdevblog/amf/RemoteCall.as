package com.apdevblog.amf 
{
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
	public class RemoteCall 
	{
		public var slotName:String;
		public var methodName:String;
		public var param:Array;
		
		/**
		 * 
		 */
		public function RemoteCall(slotName:String, methodName:String, args:Array)
		{
			this.slotName = slotName;
			this.methodName = methodName;
			this.param = args;
		}
		
		public function toString():String
		{
			return "[RemoteCall slotName=" + slotName + " methodName=" + methodName + " param=" + param + "]";
		}
		
		public function get ciPath():String
		{
			return param[0] as String;
		}

		public function get absoluteServicePath():String
		{
			return slotName + "." + methodName;
		}
	}
}
