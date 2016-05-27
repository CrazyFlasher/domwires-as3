/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.factory
{
	import com.crazyfm.core.common.*;

	import flash.utils.Dictionary;

	public class AppFactory
	{
		private static var instance:AppFactory;

		public static function getSingletonInstance():AppFactory
		{
			if (!instance)
			{
				instance = new AppFactory();
			}

			return instance;
		}

		private var typeMapping:Dictionary = new Dictionary()/*Class, Class*/;
		private var pool:Dictionary = new Dictionary()/*Class, PoolModel*/;

		public function AppFactory()
		{

		}

		ns_app_factory function map(type:Class, toType:Class):AppFactory
		{
			if (typeMapping[type])
			{
				log("Warning: type " + type + "is mapped to " + typeMapping[type] + ". Remapping to " + toType);
			}
			typeMapping[type] = toType;

			return this;
		}

		public function hasMappingForType(type:Class):Boolean
		{
			return typeMapping[type] != null;
		}

		ns_app_factory function unmap(type:Class):void
		{
			if(typeMapping[type])
			{
				delete typeMapping[type];
			}
		}

		public function getInstance(type:Class, ...constructorArgs):*
		{
			if (hasPoolForType(type))
			{
				if (constructorArgs.length > 0)
				{
					log("Warning: type " + type + " has registered pool. Ignoring constructorArgs.");
				}

				return getFromPool(type);
			}
			
			getNewInstance.apply(null, constructorArgs);
		}

		internal function getNewInstance(type:Class, ...constructorArgs):*
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

		ns_app_factory function registerPool(type:Class, capacity:uint = 5):AppFactory
		{
			if (capacity == 0)
			{
				throw new Error("Capacity should be > 0!")
			}

			if (pool[type])
			{
				log("Pool " + type + "already registered! Call unregisterPool before.");
			}else
			{
				pool[type] = new PoolModel(this, capacity);
			}

			return this;
		}

		private function getFromPool(type:Class):*
		{
			if (!pool[type])
			{
				throw new Error("Pool " + type + "is not registered! Call registerPool.");
			}

			return pool[type].get(type);
		}

		ns_app_factory function unregisterPool(type:Class):AppFactory
		{
			if(pool[type])
			{
				pool[type].dispose();

				delete pool[type];
			}

			return this;
		}

		public function hasPoolForType(type:Class):Boolean
		{
			return pool[type] != null;
		}

		ns_app_factory function clear():AppFactory
		{
			for each (var poolModel:PoolModel in pool)
			{
				poolModel.dispose();
			}
			pool = new Dictionary();
			typeMapping = new Dictionary();

			return this;
		}
	}
}
