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
import flash.utils.describeType;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import org.spicefactory.lib.errors.IllegalStateError;
import org.spicefactory.lib.logging.LogContext;
import org.spicefactory.lib.logging.Logger;
import org.spicefactory.lib.reflect.types.Any;
import org.spicefactory.lib.reflect.types.Void;
import org.spicefactory.lib.util.ClassUtil;
import org.spicefactory.lib.util.collection.SimpleMap;

/**
 * Represents a class or interface and allows reflection on its name, properties and methods.
 * Instances of this class can be obtained with one of the three static methods (<code>forName</code>,
 * <code>forClass</code> or <code>forInstance</code>). ClassInfo instances are cached and rely on
 * the XML returned by <code>flash.utils.describeType</code> internally.
 * 
 * @author Jens Halm
 */
public class ClassInfo {


	private static const logger:Logger = LogContext.getLogger(getQualifiedClassName(ClassInfo));

	private static var cache:Object = new Object();
	
	
	/**
	 * Returns an instance representing the class or interface with the specified name.
	 * 
	 * @param name the fully qualified name of the class or interface
	 * @return an instance representing the class or interface with the specified name
	 * @throws ReferenceError if the class with the specified name does not exist
	 */
	public static function forName (name:String) : ClassInfo {
		if (cache[name] != null) {
			return cache[name] as ClassInfo;
		}
		var C:Class = getClassDefinitionByName(name);
		return getClassInfo(C, name);
	}

	/**
	 * Returns an instance representing the specified class or interface.
	 * 
	 * @param clazz the class or interface to reflect on
	 * @return an instance representing the specified class or interface
	 */	
	public static function forClass (clazz:Class) : ClassInfo {
		return getClassInfo(clazz);
	}

	/**
	 * Returns an instance representing the class of the specified instance.
	 * 
	 * @param instance the instance to return the ClassInfo for
	 * @return an instance representing the class of the specified instance
	 */		
	public static function forInstance (instance:Object) : ClassInfo {
		var C:Class = instance.constructor as Class;
		return getClassInfo(C);
	}
	
	private static function getClassDefinitionByName (name:String) : Class {
		if (name == "*") {
			return Any;
		} else if (name == "void") {
			return Void;
		} else {
			try {
				return getDefinitionByName(name) as Class;
			} catch (e:ReferenceError) {
				logger.error("Unable to load class with name " + name);
				throw e;
			}
		}
		return null; // unreachable statement, but compiler insists... 
	}
	
	private static function getClassInfo (clazz:Class, name:String = null) : ClassInfo {
		if (name == null) {
			name = getQualifiedClassName(clazz);
		}
		if (cache[name] != null) {
			return cache[name] as ClassInfo;
		}
		var ci:ClassInfo = new ClassInfo(name, clazz);
		cache[name] = ci;
		return ci;		
	}

	
	private var _name:String;
	
	private var initialized:Boolean;
	private var type:Class;
	
	private var properties:SimpleMap;
	private var staticProperties:SimpleMap;
	private var methods:SimpleMap;
	private var staticMethods:SimpleMap;
	private var superClasses:Array;
	private var interfaces:Array;
	private var _interface:Boolean;
	
	/**
	 * @private
	 */
	function ClassInfo (name:String, type:Class) {
		this._name = name;
		this.type = type;
	}
	
	private function initCollections () : void {
		properties = new SimpleMap();
		staticProperties = new SimpleMap();
		methods = new SimpleMap();
		staticMethods = new SimpleMap();
		superClasses = new Array();
		interfaces = new Array();
	}
	
	private function init () : void {
		if (initialized) return;
		if (type != Object) {
			_interface = true;
		}
		initCollections();
		var xml:XML = describeType(type);
		var staticChildren:XMLList = xml.children();
		for each (var staticChild:XML in staticChildren) {
			var name:String = staticChild.localName() as String;
			if (name == "accessor") {
				var staticAccessor:Property = Property.fromAccessorXML(staticChild, true, type);
				staticProperties.put(staticAccessor.name, staticAccessor);
			} else if (name == "constant") {
				var staticConstant:Property = Property.fromConstantXML(staticChild, true, type);
				staticProperties.put(staticConstant.name, staticConstant);
			} else if (name == "variable") {
				var staticVariable:Property = Property.fromVariableXML(staticChild, true, type);
				staticProperties.put(staticVariable.name, staticVariable);
			} else if (name == "method") {
				var sm:Method = Method.fromXML(staticChild, true, type);
				staticMethods.put(sm.name, sm);
			} else if (name == "factory") {
				var instanceChildren:XMLList = staticChild.children();
				for each (var instanceChild:XML in instanceChildren) {
					var childName:String = instanceChild.localName() as String;
					if (childName == "accessor") {
						var accessor:Property = Property.fromAccessorXML(instanceChild, false, type);
						properties.put(accessor.name, accessor);
					} else if (childName == "constant") {
						var constant:Property = Property.fromConstantXML(instanceChild, false, type);
						properties.put(constant.name, constant);
					} else if (childName == "variable") {
						var variable:Property = Property.fromVariableXML(instanceChild, false, type);
						properties.put(variable.name, variable);
					} else if (childName == "method") {
						var m:Method = Method.fromXML(instanceChild, false, type);
						methods.put(m.name, m);
					} else if (childName == "extendsClass") {
						_interface = false;
						superClasses.push(getDefinitionByName(instanceChild.@type));
					} else if (childName == "implementsInterface") {
						interfaces.push(getDefinitionByName(instanceChild.@type));
					}
				}
			}
		}
		initialized = true;
	}
	
	/**
	 * Returns the fully qualified class name for this instance.
	 * 
	 * @return the fully qualified class name for this instance 
	 */
	public function get name () : String {
		return _name;
	}
	
	
	/**
	 * Creates a new instance of the class represented by this ClassInfo instance.
	 * 
	 * @param constructorArgs the argumenst to pass to the constructor
	 * @return a new instance of the class represented by this ClassInfo instance
	 */
	public function newInstance (constructorArgs:Array) : Object {
		init();
		if (_interface) {
			throw new IllegalStateError("Cannot instantiate an interface: " + name);
		}
		return ClassUtil.createNewInstance(type, constructorArgs);
	}
	
	/**
	 * Returns the class this instance represents.
	 * 
	 * @return the class this instance represents
	 */
	public function getClass () : Class {
		return type;
	}
	
	/**
	 * Indicates whether this type is an interface.
	 * 
	 * @return true if this type is an interface
	 */
	public function isInterface () : Boolean {
		init();
		return _interface;
	}
	
	/**
	 * Returns the Property instance for the specified property name.
	 * The property may be declared in this class or in one of its superclasses or superinterfaces.
	 * The property must be public and non-static 
	 * and may have been declared with var, const or implicit getter/setter functions.
	 * 
	 * @param name the name of the property
	 * @return the Property instance for the specified property name or null if no such property exists
	 */
	public function getProperty (name:String) : Property {
		init();
		return properties.get(name) as Property;
	}
	
	/**
	 * Returns Property instances for all public, non-static properties of this class.
	 * Included are all properties declared in this class 
	 * or in one of its superclasses or superinterfaces with var, const or implicit getter/setter
	 * functions.
	 * 
	 * @return Property instances for all public, non-static properties of this class
	 */
	public function getProperties () : Array {
		init();
		return properties.values;
	}

	/**
	 * Returns the Property instance for the specified property name.
	 * The property must be public and static and may have been declared 
	 * with var, const or implicit getter/setter functions.
	 * Static properties of superclasses or superinterfaces are not included.
	 * 
	 * @param name the name of the static property
	 * @return the Property instance for the specified property name or null if no such property exists
	 */	
	public function getStaticProperty (name:String) : Property {
		init();
		return staticProperties.get(name) as Property;
	}

	/**
	 * Returns Property instances for all public, static properties of this class.
	 * Included are all static properties declared in this class
	 * with var, const or implicit getter/setter
	 * functions.
	 * 
	 * @return Property instances for all public, static properties of this class
	 */	
	public function getStaticProperties () : Array {
		init();
		return staticProperties.values;
	}
	
	/**
	 * Returns the Method instance for the specified method name.
	 * The method must be public, non-static and
	 * may be declared in this class or in one of its superclasses or superinterfaces.
	 * 
	 * @param name the name of the method
	 * @return the Method instance for the specified method name or null if no such method exists
	 */
	public function getMethod (name:String) : Method {
		init();
		return methods.get(name) as Method;
	}
	
	/**
	 * Returns Method instances for all public, non-static methods of this class.
	 * Included are all methods declared in this class 
	 * or in one of its superclasses or superinterfaces.
	 * 
	 * @return Method instances for all public, non-static methods of this class
	 */
	public function getMethods () : Array {
		init();
		return methods.values;
	}
	
	/**
	 * Returns the Method instance for the specified method name.
	 * The method must be public, static and
	 * must be declared in this class.
	 * 
	 * @param name the name of the static method
	 * @return the Method instance for the specified method name or null if no such method exists
	 */
	public function getStaticMethod (name:String) : Method {
		init();
		return staticMethods.get(name) as Method;
	}

	/**
	 * Returns Method instances for all public, static methods of this class.
	 * Included are all static methods declared in this class.
	 * 
	 * Method instances for all public, static methods of this class
	 */	
	public function getStaticMethods () : Array {
		init();
		return staticMethods.values;
	}
	
	/**
	 * Returns the superclass of the class represented by this ClassInfo instance.
	 * 
	 * @return the superclass of the class represented by this ClassInfo instance
	 */
	public function getSuperClass () : Class {
		init();
		return superClasses[0] as Class;
	}
	
	/**
	 * Returns all superclasses or superinterfaces of the class or interface
	 * represented by this ClassInfo instance. The first element in the Array
	 * is always the immediate superclass.
	 * 
	 * @return all superclasses or superinterfaces of the class or interface
	 * represented by this ClassInfo instance
	 */
	public function getSuperClasses () : Array {
		init();
		return superClasses.concat();
	}

	/**
	 * Returns all interfaces implemented by the class
	 * represented by this ClassInfo instance.
	 * 
	 * @return all interfaces implemented by the class
	 * represented by this ClassInfo instance
	 */	
	public function getInterfaces () : Array {
		init();
		return interfaces.concat();
	}
	
	/**
	 * Checks whether the class or interface represented by this ClassInfo instance
	 * is a subclass or subinterface of the specified class.
	 * 
	 * @return true if the class or interface represented by this ClassInfo instance
	 * is a subclass or subinterface of the specified class
	 */
	public function isType (c:Class) : Boolean {
		init();
		if (type == c) return true;
		for each (var sc:Class in superClasses) {
			if (sc == c) return true;
		}
		for each (var inf:Class in interfaces) {
			if  (inf == c) return true;
		}
		return false;
	}
	

}

}