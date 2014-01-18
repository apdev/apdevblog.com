package com.apdevblog.examples.indexhibit.model.vo 
{

	/**
	 * SHORT DESCRIPTION.
	 *
	 * <p>long description (if any...).</p>
	 * 
	 * ActionScript 3.0 / Flash 9
	 *
	 * @package    com.apdevblog.examples.indexhibit.model.vo
	 * @author     Philipp Kyeck / philipp[at]beta-interactive.de
	 * @copyright  2009 beta_interactive
	 * @version    SVN: $Id: ExhibitVo.as 8 2009-08-31 14:05:34Z phil $
	 */
	public class ExhibitVo 
	{
		public var id:int;
		public var title:String;
		public var content:String;
		public var date:int;
		public var category:String;
		public var order:int;
		public var url:String;
		public var year:int;
		
		public var images:Array;

		public var _explicitType:String;
	}
}
