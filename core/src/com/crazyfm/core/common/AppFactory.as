/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.common
{
	import flash.utils.Dictionary;

	public class AppFactory
	{
		private static var typeMapping:Dictionary = new Dictionary()/*Class, Class*/;
		private static var pool:Dictionary = new Dictionary()/*Class, PoolModel*/;

		ns_app_factory static function map(type:Class, toType:Class):void
		{
			if (typeMapping[type])
			{
				log("Warning: type " + type + "is mapped to " + typeMapping[type] + ". Remapping to " + toType);
			}
			typeMapping[type] = toType;
		}

		ns_app_factory static function hasMappingForType(type:Class):Boolean
		{
			return typeMapping[type] != null;
		}

		ns_app_factory static function unmap(type:Class):void
		{
			if(typeMapping[type])
			{
				delete typeMapping[type];
			}
		}

		public static function getNewInstance(type:Class, ...constructorArgs):*
		{
			var t:Class;

			if (!typeMapping[type])
			{
				log("Warning: type " + type + " is not mapped to any other type. Creating new instance of " + type);

				t = type;
			}else
			{
				t = typeMapping[type];
			}

			switch (constructorArgs.length)
			{
				case 0: return new t();
				case 1: return new t(constructorArgs[0]);
				case 2: return new t(constructorArgs[0], constructorArgs[1]);
				case 3: return new t(constructorArgs[0], constructorArgs[1], constructorArgs[2]);
				case 4: return new t(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3]);
				case 5: return new t(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4]);
				case 6: return new t(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5]);
				case 7: return new t(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6]);
				default: throw new Error("getNewInstance supports maximum 7 constructor arguments.");
			}
		}

		ns_app_factory static function registerPool(type:Class, capacity:int = 5):void
		{
			if (pool[type])
			{
				log("Pool " + type + "already registered! Call unregisterPool before.");
			}else
			{
				pool[type] = new PoolModel(capacity);
			}
		}

		ns_app_factory static function getFromPool(type:Class):*
		{
			if (!pool[type])
			{
				throw new Error("Pool " + type + "is not registered! Call registerPool.");
			}

			return pool[type].get(type);
		}

		ns_app_factory static function unregisterPool(type:Class):void
		{
			if(pool[type])
			{
				pool[type].dispose();

				delete pool[type];
			}
		}

		ns_app_factory static function hasPoolForType(type:Class):Boolean
		{
			return pool[type] != null;
		}

		ns_app_factory static function clear():void
		{
			for each (var poolModel:PoolModel in pool)
			{
				poolModel.dispose();
			}
			pool = new Dictionary();
			typeMapping = new Dictionary();
		}
	}
}

import com.crazyfm.core.common.AppFactory;
import com.crazyfm.core.common.ns_app_factory;

use namespace ns_app_factory;

internal class PoolModel
{
	private var list:Array = [];
	private var capacity:int;

	private var currentIndex:int;

	public function PoolModel(capacity:int)
	{
		this.capacity = capacity;
	}

	internal function get(type:Class):*
	{
		var instance:*;

		if (list.length < capacity)
		{
			instance = AppFactory.getNewInstance(type);
			list.push(instance);
		}else
		{
			instance = list[currentIndex];

			currentIndex++;

			if (currentIndex == capacity)
			{
				currentIndex = 0;
			}
		}

		return instance
	}

	internal function dispose():void
	{
		list = null;
	}
}
