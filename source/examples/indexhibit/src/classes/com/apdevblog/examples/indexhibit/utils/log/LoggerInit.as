package com.apdevblog.examples.indexhibit.utils.log 
{
	import org.spicefactory.lib.logging.Appender;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.LogFactory;
	import org.spicefactory.lib.logging.LogLevel;
	import org.spicefactory.lib.logging.impl.AlconAppender;
	import org.spicefactory.lib.logging.impl.DefaultLogFactory;
	import org.spicefactory.lib.logging.impl.TraceAppender;	
	
	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.utils.log
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: LoggerInit.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class LoggerInit 
	{
		public static function init(testMode:String):void
		{
			var factory:LogFactory = new DefaultLogFactory();
			
			// you can filter log statements by setting the root log level
			// or by adding log level to packages or classes !
			
			factory.setRootLogLevel(LogLevel.WARN);
			
			switch(testMode)
			{
				case "aron":
					factory.addLogLevel("com.apdevblog", LogLevel.DEBUG);
				break;

				case "phil":
					factory.addLogLevel("com.apdevblog.indexhibit", LogLevel.DEBUG);
				break;
				
				default:
			}
			
			var traceApp:Appender = new TraceAppender();
			// threshold is a second level for filtering
			traceApp.threshold = LogLevel.TRACE;
			
			var alconApp:Appender = new AlconAppender();
			// threshold is a second level for filtering
			alconApp.threshold = LogLevel.TRACE;
						
			factory.addAppender(traceApp);
			factory.addAppender(alconApp);

			LogContext.factory = factory;
		}
	}
}
