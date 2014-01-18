package com.apdevblog.utils.ui 
{
	import flash.display.DisplayObject;

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 *
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.utils.ui 
	 * @author     phil / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: Index.as 8 2009-08-31 14:05:34Z phil $
	 */
	public class AlignInfo 
	{		
		public var item:DisplayObject;
		public var align:String;
		public var vpad:int;
		public var hpad:int;
		
		/**
		 * 
		 */
		public function AlignInfo(item:DisplayObject=null, align:String=null, vpad:int=0, hpad:int=0)
		{
			this.item = item;
			this.align = align;
			this.vpad = vpad;
			this.hpad = hpad;
		}
	}
}
