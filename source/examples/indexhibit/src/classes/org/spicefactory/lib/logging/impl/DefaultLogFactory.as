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
 
package org.spicefactory.lib.logging.impl {
import org.spicefactory.lib.errors.IllegalArgumentError;
import org.spicefactory.lib.logging.Appender;
import org.spicefactory.lib.logging.LogFactory;
import org.spicefactory.lib.logging.LogLevel;
import org.spicefactory.lib.logging.Logger;

/**
 * The default <code>LogFactory</code> implementation. Uses the <code>DefaultLogger</code>
 * class when creating <code>Logger</code> instances.
 * 
 * @author Jens Halm
 */
public class DefaultLogFactory implements LogFactory {
	
	
	private var appenders:Array;
	
	private var logLevels:Object;
	private var rootLogLevel:LogLevel;
	
	private var loggers:Object;
	
	private static var _logger:Logger;


	/**
	 * Creates a new instance.
	 */
	public function DefaultLogFactory () {
		appenders = new Array();
		logLevels = new Object();
		loggers = new Object();
		rootLogLevel = LogLevel.TRACE;
	}

	/**
	 * @private
	 */
	protected function get logger () : Logger {
		if (_logger == null) {
			_logger = getLogger("org.spicefactory.lib.logging.impl.DefaultLogFactory");
		}
		return _logger;
	}
	

	/**
	 * @inheritDoc
	 */
	public function addAppender (app:Appender) : void {
		appenders.push(app);
		for each (var log:Logger in loggers) {
			app.registerLogger(log);
		}
	}

	/**
	 * @inheritDoc
	 */
	public function setRootLogLevel (level:LogLevel) : void {
		if (logger.isInfoEnabled()) {
			logger.info("Set rootLogLevel = " + level);
		}
		rootLogLevel = level;
	}

	/**
	 * @inheritDoc
	 */
	public function addLogLevel (loggerName:String, level:LogLevel) : void {
		if (logger.isInfoEnabled()) {
			logger.info("Add LogLevel - name = " + loggerName + " - level = " + level);
		}
		logLevels[loggerName] = level;
	}
	
	public function refresh () : void {
		for each (var log:Logger in loggers) {
			log.level = findLevel(log.name);
		}
	}

	/**
	 * @inheritDoc
	 */
	public function getLogger (name:String) : Logger {
		if (loggers[name] != undefined) {
			return Logger(loggers[name]);
		} else {
			return createLogger(name);
		}
	}
	
	private function createLogger (name:String) : Logger {
		var level:LogLevel = findLevel(name);
		var log:Logger = new DefaultLogger(name, level);
		loggers[name] = log;
		for each (var app:Appender in appenders) {
			app.registerLogger(log);
		}
		return log;
	}
	
	private function findLevel (name:String) : LogLevel {
		if (logLevels[name] != undefined) {
			return LogLevel(logLevels[name]);
		}
		var parentNS:String = getParentNameSpace(name);
		if (parentNS != null) {
			return findLevel(parentNS);
		} else if (rootLogLevel != null) {
			return rootLogLevel;
		} else {
			throw new IllegalArgumentError("No configuration found for Logger - name = " + name);
		}
	}
	
	private function getParentNameSpace (name:String) : String {
		var idx:int = name.lastIndexOf("::"); // needed for fully qualified class names
		if (idx == -1) {
			idx = name.lastIndexOf(".");
		}
		if (idx == -1) return null;
		else return name.substring(0, idx);
	}
	
}

}