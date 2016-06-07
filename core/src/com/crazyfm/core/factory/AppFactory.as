/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.factory
{
	import com.crazyfm.core.common.*;

	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	use namespace ns_app_factory;

	public class AppFactory
	{
		private static var instance:AppFactory;

		public static function getSingletonInstance(autoInjectDependencies:Boolean = true):AppFactory
		{
			if (!instance)
			{
				instance = new AppFactory(autoInjectDependencies);
			}

			return instance;
		}

		private var typeMapping:Dictionary = new Dictionary()/*Class, Class*/;
		private var pool:Dictionary = new Dictionary()/*Class, PoolModel*/;
		private var autoInjectDependencies:Boolean;

		public function AppFactory(autoInjectDependencies:Boolean = true)
		{
			this.autoInjectDependencies = autoInjectDependencies;
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
			var obj:*;

			if (hasPoolForType(type))
			{
				if (constructorArgs.length > 0)
				{
					log("Warning: type " + type + " has registered pool. Ignoring constructorArgs.");
				}

				//Do not inject dependencies automatically to object taken from pool.
				//Call injectDependencies to inject manually.
				obj = getFromPool(type);
			}else
			{
				switch (constructorArgs.length)
				{
					case 0: obj = getNewInstance(type); break;
					case 1: obj = getNewInstance(type, constructorArgs[0]); break;
					case 2: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1]); break;
					case 3: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2]); break;
					case 4: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3]); break;
					case 5: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4]); break;
					case 6: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5]); break;
					case 7: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6]); break;
					default: throw new Error("getNewInstance supports maximum 7 constructor arguments.");
				}

				if (autoInjectDependencies)
				{
					obj = injectDependencies(obj);
				}
			}

			return obj;
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

		public function getSingleton(type:Class):*
		{
			if (!hasPoolForType(type))
			{
				registerPool(type, 1);
			}

			return getInstance(type);
		}

		ns_app_factory function removeSingleton(type:Class):AppFactory
		{
			if (hasPoolForType(type))
			{
				unregisterPool(type);
			}else
			{
				log(type + " is not registered as singleton!");
			}

			return this;
		}

		ns_app_factory function clearPools():AppFactory
		{
			for each (var poolModel:PoolModel in pool)
			{
				poolModel.dispose();
			}
			pool = new Dictionary();

			return this;
		}

		ns_app_factory function clearMappings():AppFactory
		{
			typeMapping = new Dictionary();

			return this;
		}

		ns_app_factory function clear():AppFactory
		{
			clearPools();
			clearMappings();

			return this;
		}

		public function injectDependencies(object:*):*
		{
			const describeT:XML = describeType(object);

			var needToInject:Boolean;
			var injectionOccurred:Boolean;
			var postConstructMethodName:String;

			for each(var variable:XML in describeT..variable) {
				needToInject = false;

				if (variable.metadata.length() > 1)
				{
					for each (var variableMetaTag:XML in variable.metadata)
					{
						if(variableMetaTag.@name == "Autowired")
						{
							needToInject = true;
							break;
						}
					}
				}

				if (needToInject)
				{
					if (!injectionOccurred)
					{
						injectionOccurred = true;
					}

					object[variable.@name] = getInstance(getDefinitionByName(String(variable.@type).replace(/::/g, ".")) as Class);
				}
			}

			if (injectionOccurred)
			{
				for each(var method:XML in describeT..method) {
					if (postConstructMethodName != null)
					{
						break;
					}else
					{
						if (method.metadata.length() > 1)
						{
							for each (var methodMetaTag:XML in method.metadata)
							{
								if(methodMetaTag.@name == "PostConstruct")
								{
									//TODO: PreDestroy
									postConstructMethodName = method.@name;
									break;
								}
							}
						}
					}
				}

				if (postConstructMethodName != null)
				{
					object[postConstructMethodName]();
				}
			}

			return object;
		}
	}
}
