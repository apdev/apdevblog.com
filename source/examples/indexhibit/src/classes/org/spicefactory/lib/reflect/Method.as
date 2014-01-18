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

import org.spicefactory.lib.reflect.errors.MethodInvocationError;

/**
 * Represents a single method.
 * 
 * @author Jens Halm
 */
public class Method	{


	private var _name:String;
	private var _static:Boolean;
	private var _returnType:Class;
	private var _parameters:Array;
	
	private var owner:Class;
	private var minArgs:uint;
	private var maxArgs:uint;
	
	
	/**
	 * @private
	 */
	function Method (name:String, returnType:Class, params:Array, s:Boolean, owner:Class) {
		this._name = name;
		this._returnType = returnType;
		this._parameters = params;
		this._static = s;
		this.owner = owner;
		initParamCount();
	}
	
	/**
	 * @private
	 */
	public static function fromXML (xml:XML, isStatic:Boolean, owner:Class) : Method {
		var params:Array = new Array();
		for each (var paramTag:XML in xml.parameter) {
			params.push(Parameter.fromXML(paramTag));
		} 
		return new Method(xml.@name, ClassInfo.forName(xml.@returnType).getClass(), params, isStatic, owner);
	}
	
	private function initParamCount () : void {
		var required:uint = 0;
		for each (var param:Parameter in _parameters) {
			if (param.required) required++;
			else break;
		}
		minArgs = required;
		maxArgs = _parameters.length;
	}
	
	private function checkParamCount (count:uint) : void {
		if (count < minArgs || count > maxArgs) {
			var message:String = "Method " + name + " in class " + getQualifiedClassName(owner) + " expects "
			+ ((minArgs == maxArgs) ? minArgs : "between " + minArgs + " and " + maxArgs) + " arguments"; 
			throw new MethodInvocationError(message);
		}
	}
	
	
	/**
	 * Returns the name of the method represented by this instance.
	 * 
	 * @return the name of the method represented by this instance
	 */
	public function get name () : String {
		return _name;
	}
	
	/**
	 * Determines if the method represented by this instance is static.
	 * 
	 * @return true if the method represented by this instance is static
	 */
	public function get isStatic () : Boolean {
		return _static;
	}
	
	/**
	 * Returns the return type of the method represented by this instance.
	 * The return type <code>&#42;</code> is represented by the <code>Any</code> class and
	 * the return type void is represented by the <code>Void</code> class, both members
	 * of the <code>org.spicefactory.lib.reflect.types</code> package. All other return types
	 * are represented by their corresponding Class instance.
	 * 
	 * @return the return type of the method represented by this instance
	 */
	public function get returnType () : Class {
		return _returnType;
	}
	
	/**
	 * Returns the parameter types of the method represented by this instance.
	 * Each element in the returned Array is an instance of the <code>Parameter</code> class.
	 * 
	 * @return the parameter types of the method represented by this instance
	 */
	public function get parameters () : Array {
		return _parameters;
	}
	
	/**
	 * Invokes the method represented by this instance on the specified target instance.
	 * If necessary, parameters will be automatically converted to the required type if
	 * a matching Converter is registered for the parameter type.
	 * 
	 * @param instance the instance to invoke the method on.
	 * @param params the parameters to pass to the method
	 * @return the return value of the method that gets invoked
	 * @throws org.spicefactory.lib.reflect.errors.ConversionError if one of the specified parameters
	 * is not of the required type and can not be converted
	 * @throws org.spicefactory.lib.reflect.errors.MethodInvocationError 
	 * if the specified target instance is not of the required type
	 * @throws Error any Error thrown by the target method will not be catched by this method
	 */
	public function invoke (instance:Object, params:Array) : * {
		checkInstanceParameter(instance);
		checkParamCount(params.length);
		for (var i:uint = 0; i < params.length; i++) {
			var param:Parameter = _parameters[i] as Parameter;
			var value:* = params[i];
			params[i] = param.convertParameterValue(value);
		}
		var f:Function = (_static) ? owner[_name] : instance[_name];
		return f.apply(instance, params);
	}
	
	private function checkInstanceParameter (instance:Object) : void {
		if (_static) {
			if (instance != null) {
				throw new MethodInvocationError("Instance parameter must be null for static properties");
			}
		} else {
			if (instance == null) {
				throw new MethodInvocationError("Instance parameter must not be null for static properties");
			} else if (!(instance is owner)) {
				throw new MethodInvocationError("Instances must be of type " + getQualifiedClassName(owner));
			}
		}		
	}


}

}