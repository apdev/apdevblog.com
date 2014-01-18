package com.apdevblog.utils.ui  
{
	import flash.events.Event;	
	
	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.utils.ui 
	 * @author     phil / philipp[at]beta-interactive.de
	 * @copyright  2008 beta_interactive
	 * @version    SVN: $Id: IStageAdjustable.as 260 2008-12-02 10:00:41Z phil $
	 */
	public interface IStageAdjustable 
	{
		function onStageResize(event:Event):void;
	}
}
