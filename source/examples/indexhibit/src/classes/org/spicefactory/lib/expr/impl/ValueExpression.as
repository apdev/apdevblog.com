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
 
package org.spicefactory.lib.expr.impl {

import org.spicefactory.lib.expr.Expression;
import org.spicefactory.lib.expr.VariableResolver;
import org.spicefactory.lib.expr.PropertyResolver;
	
/**	
 * Represents a value expression without literal parts. That means the expression starts
 * with <code>${</code> and ends with <code>}</code>.
 * Example: <code>"${user.address.city}"</code>
 * 
 * @author Jens Halm
 */
public class ValueExpression implements Expression {
	
	private var _expressionString:String;
	
	private var expressionParts:Array;
	private var variableResolver:VariableResolver;
	private var propertyResolver:PropertyResolver;
	private var defaultValue:*;
	
	
	/**
	 * Creates a new expression instance.
	 * 
	 * @param expressionString the expression string
	 * @param variableResolver the VariableResolver to use for this expression
	 * @param propertyResolver the PropertyResolver to use for this expression
	 * @param defaultValue the value to use as a default if the expression cannot be resolved
	 */
	public function ValueExpression (
			expressionString:String, 
			variableResolver:VariableResolver,
			propertyResolver:PropertyResolver,
			defaultValue:*
			) {
		if (expressionString == null || expressionString.length == 0) {
			throw new IllegalExpressionError("An empty or null String is not a legal expression");
		}
		this._expressionString = expressionString;
		this.expressionParts = expressionString.split(".");
		this.variableResolver = variableResolver;
		this.propertyResolver = propertyResolver;
		this.defaultValue = defaultValue;
	}
	
	/**
	 * @inheritDoc
	 */
	public function get value () : * {
		var val:* = variableResolver.resolveVariable(expressionParts[0]);
		for (var i:Number = 1; i < expressionParts.length; i++) {
			if (val == undefined) break;
			val = propertyResolver.resolveProperty(val, expressionParts[i]);
		}
		return (val == undefined) ? defaultValue : val;
	}
	
	/**
	 * @inheritDoc
	 */
	public function get expressionString () : String {
		return "${" + _expressionString + "}";
	}	
	
}

}