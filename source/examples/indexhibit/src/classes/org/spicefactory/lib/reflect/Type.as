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

import org.spicefactory.lib.reflect.Converter;
import org.spicefactory.lib.reflect.converter.BooleanConverter;
import org.spicefactory.lib.reflect.converter.ClassConverter;
import org.spicefactory.lib.reflect.converter.ClassInfoConverter;
import org.spicefactory.lib.reflect.converter.DateConverter;
import org.spicefactory.lib.reflect.converter.IntConverter;
import org.spicefactory.lib.reflect.converter.NumberConverter;
import org.spicefactory.lib.reflect.converter.StringConverter;
import org.spicefactory.lib.reflect.converter.UintConverter;
import org.spicefactory.lib.reflect.errors.ConversionError;

/**
 * Abstract base class for the Property and Parameter class.
 * 
 * @author Jens Halm
 */
public class Type {


	private var _type:Class;

	/**
	 * @private
	 */
	function Type (type:Class) {
		_type = type;
	}

	/**
	 * Returns the class of this Property or Parameter instance.
	 * 
	 * @return the class of this Type instance
	 */
	public function get type () : Class {
		return _type;
	}
	
	/**
	 * @private
	 */
	protected function convertValue (value:*) : * {
		if (!(value is type) && value != null && type != null) {
			var conv:Converter = getConverter(type);
			if (conv == null) {
				throw new ConversionError("No converter registered for class " + getQualifiedClassName(type));
			}
			value = conv.convert(value);
		}
		return value;
	}
	
	
	private static var converters:Object;
	
	/**
	 * Registers a Converter for the specified class.
	 * Converters will be used for automatic type conversion when setting property values
	 * with Spicelib Property instances or invoking methods with Spicelib Method instances.
	 * 
	 * @param type the class for which to register the Converter
	 * @param converter the Converter instance to be used for the specified type
	 */
	public static function addConverter (type:Class, converter:Converter) : void {
		if (converters == null) {
			initConverters();
		}
		converters[getQualifiedClassName(type)] = converter;
	}
	
	/**
	 * Returns the Converter registered for the specified class.
	 * 
	 * @param type the class for which to return the registered Converter 
	 * @return the Converter registered for the specified class or null if no Converter has been
	 * registered for that class
	 */
	public static function getConverter (type:Class) : Converter {
		if (converters == null) {
			initConverters();
		}
		return converters[getQualifiedClassName(type)] as Converter;
	}
	
	private static function initConverters () : void {
		converters = new Object();
		addConverter(String, StringConverter.INSTANCE);
		addConverter(Boolean, BooleanConverter.INSTANCE);
		addConverter(Number, NumberConverter.INSTANCE);
		addConverter(int, IntConverter.INSTANCE);
		addConverter(uint, UintConverter.INSTANCE);
		addConverter(Date, DateConverter.INSTANCE);
		addConverter(Class, ClassConverter.INSTANCE);
		addConverter(ClassInfo, new ClassInfoConverter());
	}
	

}

}