package org.spicefactory.lib.logging.impl 
{
	import org.spicefactory.lib.logging.LogEvent;
	import org.spicefactory.lib.logging.LogLevel;
	import org.spicefactory.lib.logging.Logger;
	import org.spicefactory.lib.logging.impl.AbstractAppender;

	import com.hexagonstar.util.debug.Debug;	

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    org.spicefactory.lib.logging.impl
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2008 beta_interactive
	 * @version    SVN: $Id: AlconAppender.as 117 2008-06-09 15:05:47Z phil $
	 */
	public class AlconAppender extends AbstractAppender 
	{
		private var needsLineFeed:Boolean;

		public function AlconAppender()
		{
			super();
			needsLineFeed = false;
			Debug.clear();
		}

		/**
		 * @private
		 */
		protected override function handleLogEvent(event:LogEvent):void 
		{
			if (isBelowThreshold(event.level)) return;
			var loggerName:String = Logger(event.target).name;
			var logMessage:String;
			if ((event.level.toValue() <= LogLevel.INFO.toValue()) && event.error == null) {
				var index:int = loggerName.lastIndexOf(".");
				if (index != -1) loggerName = loggerName.substring(index + 1);
				logMessage = "[" + loggerName + "]\t" + event.message;
				needsLineFeed = true;
			} else {
				var lf:String = (needsLineFeed) ? "\n" : "";
				logMessage = lf + "  *** " + event.level + " *** " + loggerName + " ***\n" + event.message + "\n";
				if (event.error != null) {
					var stackTrace:String = event.error.getStackTrace();
					if (stackTrace != null && stackTrace.length > 0) {
						logMessage += stackTrace + "\n";
					}
				}
				needsLineFeed = false;
			}
			
			var alconLevel:Number;
			// map level to alcon logger
			switch(event.level) {
				case LogLevel.DEBUG:
					alconLevel = 0;
					break;
				case LogLevel.INFO:
					alconLevel = 1;
					break;
				case LogLevel.WARN:
					alconLevel = 2;
					break;
				case LogLevel.ERROR:
					alconLevel = 3;
					break;
			}
			Debug.trace(logMessage, false, alconLevel);
		}
	}
}
