/*
 * Copyright 2007 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
package org.spicefactory.lib.reflect {
	

/**
 * Represents a single parameter of a method.
 * 
 * @author Jens Halm
 */
public class Parameter extends Type	{

	private var _required:Boolean;

	/**
	 * @private
	 */	
	function Parameter (type:Class, required:Boolean) {
		super(type);
		_required = required;
	}
	
	/**
	 * @private
	 */
	internal static function fromXML (xml:XML) : Parameter {
		var required:Boolean = (xml.@optional == "false");
		return new Parameter(ClassInfo.forName(xml.@type).getClass(), required);
	}
	
	/**
	 * Checks whether this instance represents a required parameter.
	 * 
	 * @return true if this instance represents a required parameter
	 */
	public function get required () : Boolean {
		return _required;
	}
	
	/**
	 * @private
	 */
	internal function convertParameterValue (value:*) : * {
		return super.convertValue(value);
	}
	

}

}