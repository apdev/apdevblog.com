package com.apdevblog.examples.indexhibit.controller.app 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.controller
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: StartupCommand.as 12 2009-09-17 19:26:01Z phil $
	 */
	public class StartupCommand extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void
		{
			addSubCommand(DataPrepCommand);
			addSubCommand(ViewPrepCommand);
			addSubCommand(LoadDataCommand);
		}
	}
}
