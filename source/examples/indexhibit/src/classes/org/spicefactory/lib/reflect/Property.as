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
import flash.utils.getQualifiedClassName;

import org.spicefactory.lib.reflect.errors.PropertyError;

/**
 * Represents a single property. 
 * The property may have been declared with var, const or implicit getter/setter functions
 * 
 * @author Jens Halm
 */
public class Property extends Type {


	private var owner:Class;
	
	private var _name:String;
	private var _isStatic:Boolean;
	private var _readable:Boolean;
	private var _writable:Boolean;
	
	
	/**
	 * @private
	 */
	function Property (name:String, type:Class, readable:Boolean, writable:Boolean, s:Boolean, owner:Class) {
		super(type);
		this.owner = owner;
		this._name = name;
		this._readable = readable;
		this._writable = writable;
		this._isStatic = s;
	}
	
	/**
	 * @private
	 */
	internal static function fromAccessorXML (x:XML, isStatic:Boolean, owner:Class) : Property {
		var access:String = x.@access;
		var readable:Boolean = (access != "writeonly");
		var writable:Boolean = (access != "readonly");
		return fromXML(x, readable, writable, isStatic, owner);
	}
	
	/**
	 * @private
	 */
	internal static function fromVariableXML (x:XML, isStatic:Boolean, owner:Class) : Property {
		return fromXML(x, true, true, isStatic, owner);
	}
	
	/**
	 * @private
	 */
	internal static function fromConstantXML (x:XML, isStatic:Boolean, owner:Class) : Property {
		return fromXML(x, true, false, isStatic, owner);
	}
	
	private static function fromXML 
			(x:XML, readable:Boolean, writable:Boolean, isStatic:Boolean, owner:Class) : Property {
		var C:Class = ClassInfo.forName(x.@type).getClass();
		return new Property(x.@name, C, readable, writable, isStatic, owner); 		
	}
	
	
	/**
	 * Returns the name of the property.
	 * 
	 * @return the name of the property
	 */
	public function get name () : String {
		return _name;
	}
	
	/**
	 * Determines if this instance represents a static property.
	 * 
	 * @return true if this instance represents a static property
	 */
	public function get isStatic () : Boolean {
		return _isStatic;
	}
	
	/**
	 * Determines if this instance represents a readable property.
	 * 
	 * @return true if this instance represents a readable property
	 */
	public function get readable () : Boolean {
		return _readable;
	}
	
	/**
	 * Determines if this instance represents a writable property.
	 * Properties declared with var or an implicit setter method are writable.
	 * Properties declared with const or with an implicit getter without matching setter method
	 * are not writable.
	 * 
	 * @return true if this instance represents a writable property
	 */
	public function get writable () : Boolean {
		return _writable;
	}
	
	/**
	 * Returns the value of the property represented by this instance in the specified target instance.
	 * 
	 * @param instance the instance whose property value should be retrieved or null if the property
	 * is static
	 * @return the value of the property represented by this instance in the specified target instance
	 * @throws org.spicefactory.lib.reflect.errors.PropertyError if the property is not readable or
	 * if the specified target instance is not of the required type
	 */
	public function getValue (instance:Object) : * {
		if (!_readable) {
			throw new PropertyError("Property " + _name + " of class " + getQualifiedClassName(type) + " is write-only");
		}
		checkInstanceParameter(instance);
		return (_isStatic) ? owner[_name] : instance[_name];
	}
	
	/**
	 * Sets the value of the property represented by this instance in the specified target instance.
	 * 
	 * @param instance the instance whose property value should be set or null if the property
	 * is static
	 * @param value the new value for the property
	 * @throws org.spicefactory.lib.reflect.errors.ConversionError if the specified value is not
	 * of the required type and cannot be converted
	 * @throws org.spicefactory.lib.reflect.errors.PropertyError if the property is not writable or
	 * if the specified target instance is not of the required type
	 */
	public function setValue (instance:Object, value:*) : void {
		if (!_writable) {
			throw new PropertyError("Property " + _name + " of class " + getQualifiedClassName(type) + " is read-only");
		}
		checkInstanceParameter(instance);
		value = convertValue(value);
		if (_isStatic) {
			owner[_name] = value;
		} else {
			instance[_name] = value;
		}
	}
	
	private function checkInstanceParameter (instance:Object) : void {
		if (_isStatic) {
			if (instance != null && instance != owner) {
				throw new PropertyError("Instance parameter must be of type Class or null for static properties");
			}
		} else {
			if (instance == null) {
				throw new PropertyError("Instance parameter must not be null for non-static properties");
			} else if (!(instance is owner)) {
				throw new PropertyError("Instances must be of type " + getQualifiedClassName(owner));
			}
		}		
	}


}

}