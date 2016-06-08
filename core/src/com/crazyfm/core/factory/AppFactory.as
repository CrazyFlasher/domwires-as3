/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.factory
{
	import avmplus.DescribeTypeJSON;

	import com.crazyfm.core.common.*;

	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	use namespace ns_app_factory;

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
		private var injectionMap:Dictionary = new Dictionary()/*Class, InjectionDataVo*/;

		private var describeTypeJSON:DescribeTypeJSON = new DescribeTypeJSON();

		public var autoInjectDependencies:Boolean = true;
		public var verbose:Boolean = false;

		public function AppFactory()
		{

		}

		ns_app_factory function map(type:Class, toType:Class):AppFactory
		{
			if (verbose && typeMapping[type])
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
				if (verbose && constructorArgs.length > 0)
				{
					log("Warning: type " + type + " has registered pool. Ignoring constructorArgs.");
				}

				//Do not inject dependencies automatically to object, that is taken from pool.
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
					obj = injectDependencies(type, obj);
				}
			}

			return obj;
		}

		internal function getNewInstance(type:Class, ...constructorArgs):*
		{
			var t:Class;

			if (!typeMapping[type])
			{
				if (verbose)
				{
					log("Warning: type " + type + " is not mapped to any other type. Creating new instance of " + type);
				}

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

			if (verbose && pool[type])
			{
				log("Pool " + type + " already registered! Call unregisterPool before.");
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
			if (verbose){
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

		public function injectDependencies(type:Class, object:*):*
		{
			var injectionData:InjectionDataVo = getInjectionData(type);

			var objVar:String;
			for (objVar in injectionData.variables)
			{
				object[objVar] = getInstance(getDefinitionByName(injectionData.variables[objVar]) as Class);
			}

			if (injectionData.postConstructName != null)
			{
				object[injectionData.postConstructName]();
			}

			return object;
		}

		private function getInjectionData(type:Class):InjectionDataVo
		{
			var injectionData:InjectionDataVo = injectionMap[type];

			if (!injectionData)
			{
				injectionData = new InjectionDataVo();

				var dtJson:Object = describeTypeJSON.getInstanceDescription(type);

				var metadata:Object;
				var method:Object;
				var variable:Object;

				for each (method in dtJson.traits.methods)
				{
					for each (metadata in method.metadata)
					{
						if (injectionData.postConstructName && injectionData.preDestroyName)
						{
							break;
						}else
						if (metadata.name == "PostConstruct")
						{
							injectionData.postConstructName = method.name;
						}else
						if (metadata.name == "PreDestroy")
						{
							injectionData.preDestroyName = method.name;
						}
					}
				}
				for each (variable in dtJson.traits.variables)
				{
					for each (metadata in variable.metadata)
					{
						if (metadata.name == "Autowired")
						{
							injectionData.variables[variable.name] = variable.type.replace(/::/g, ".");
						}
					}
				}

				injectionMap[type] = injectionData;
			}

			return injectionData;
		}

		/*public function disposeInstance(object:*):AppFactory
		{
			return this;
		}*/
	}
}

import flash.utils.Dictionary;

internal class InjectionDataVo
{
	internal var variables:Dictionary/*String, String*/ = new Dictionary();
	internal var postConstructName:String;
	internal var preDestroyName:String;

	public function InjectionDataVo()
	{

	}
}
