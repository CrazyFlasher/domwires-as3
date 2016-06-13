/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.factory
{
	import avmplus.DescribeTypeJSON;

	import com.crazyfm.core.common.AbstractDisposable;

	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	public class AppFactory extends AbstractDisposable implements IAppFactory
	{
		//TODO: profiler test
		private static var instance:IAppFactory;

		/**
		 * Returns <code>IAppFactory</code> singleton instance.
		 * @return
		 */
		public static function getSingletonInstance():IAppFactory
		{
			if (!instance)
			{
				instance = new AppFactory();
			}

			return instance;
		}

		private var typeMapping:Dictionary = new Dictionary()/*Class, Class*/;
		private var instanceMapping:Dictionary = new Dictionary()/*Object, Class*/;
		private var pool:Dictionary = new Dictionary()/*Class, PoolModel*/;
		private var injectionMap:Dictionary = new Dictionary()/*Class, InjectionDataVo*/;

		private var describeTypeJSON:DescribeTypeJSON = new DescribeTypeJSON();

		/**
		 * Automatically injects dependencies to newly created objects, using <code>getInstance</code> method.
		 */
		private var _autoInjectDependencies:Boolean = true;

		/**
		 * Prints out extra information to logs.
		 * Useful for debugging, but leaks performance.
		 */
		private var _verbose:Boolean = false;

		public function AppFactory()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function map(type:Class, to:*):IAppFactory
		{
			if (to is Class)
			{
				if (_verbose && typeMapping[type])
				{
					log("Warning: type " + type + " is mapped to type " + typeMapping[type] + ". Remapping to " + to);
				}
				typeMapping[type] = to;
			}else
			if (to is Object)
			{
				if (_verbose && instanceMapping[type])
				{
					log("Warning: type " + type + " is mapped to instance " + typeMapping[type] + ". Remapping to " + to);
				}
				instanceMapping[type] = to;
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function hasMappingForType(type:Class):Boolean
		{
			return typeMapping[type] != null || instanceMapping[type] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(type:Class):IAppFactory
		{
			if(typeMapping[type])
			{
				delete typeMapping[type];
			}

			if(instanceMapping[type])
			{
				delete instanceMapping[type];
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function getInstance(type:Class, ...constructorArgs):*
		{
			if (instanceMapping[type])
			{
				return instanceMapping[type];
			}

			var obj:*;

			if (hasPoolForType(type))
			{
				if (_verbose && constructorArgs.length > 0)
				{
					log("Warning: type " + type + " has registered pool. Ignoring constructorArgs.");
				}

				//Do not inject dependencies automatically to object, that is taken from pool.
				//Call injectDependencies to inject manually.
				obj = getFromPool(type);
			}else
			{
				//TODO: find better solution
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
					case 8: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7]); break;
					case 9: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8]); break;
					case 10: obj = getNewInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8], constructorArgs[9]); break;
					default: throw new Error("getNewInstance supports maximum 10 constructor arguments.");
				}

				if (_autoInjectDependencies)
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
				if (_verbose)
				{
					log("Warning: type " + type + " is not mapped to any other type. Creating new instance of " + type);
				}

				t = type;
			}else
			{
				t = typeMapping[type];
			}

			//TODO: find better solution
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
				case 8: return new t(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7]);
				case 9: return new t(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8]);
				case 10: return new t(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8], constructorArgs[9]);
				default: throw new Error("getNewInstance supports maximum 10 constructor arguments.");
			}
		}

		/**
		 * @inheritDoc
		 */
		public function registerPool(type:Class, capacity:uint = 5):IAppFactory
		{
			if (capacity == 0)
			{
				throw new Error("Capacity should be > 0!")
			}

			if (_verbose && pool[type])
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

		/**
		 * @inheritDoc
		 */
		public function unregisterPool(type:Class):IAppFactory
		{
			if(pool[type])
			{
				pool[type].dispose();

				delete pool[type];
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function hasPoolForType(type:Class):Boolean
		{
			return pool[type] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function getSingleton(type:Class):*
		{
			if (!hasPoolForType(type))
			{
				registerPool(type, 1);
			}

			return getInstance(type);
		}

		/**
		 * @inheritDoc
		 */
		public function removeSingleton(type:Class):IAppFactory
		{
			if (hasPoolForType(type))
			{
				unregisterPool(type);
			}else
			if (_verbose){
				log(type + " is not registered as singleton!");
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function clearPools():IAppFactory
		{
			for each (var poolModel:PoolModel in pool)
			{
				poolModel.dispose();
			}
			pool = new Dictionary();

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function clearMappings():IAppFactory
		{
			typeMapping = new Dictionary();
			instanceMapping = new Dictionary();

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function clear():IAppFactory
		{
			clearPools();
			clearMappings();

			return this;
		}

		/**
		 * @inheritDoc
		 */
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
			var mappedType:Class = typeMapping[type] != null ? typeMapping[type] : type;

			var injectionData:InjectionDataVo = injectionMap[mappedType];

			if (!injectionData)
			{
				injectionData = new InjectionDataVo();

				var dtJson:Object = describeTypeJSON.getInstanceDescription(mappedType);

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

				injectionMap[mappedType] = injectionData;
			}

			return injectionData;
		}

		/**
		 * Clears all pools, mappings and injection data of current <code>AppFactory</code>.
		 */
		override public function dispose():void
		{
			super.dispose();

			typeMapping = null;
			instanceMapping = null;

			for each (var poolModel:PoolModel in pool)
			{
				poolModel.dispose();
			}

			pool = null;

			for each (var injectionData:InjectionDataVo in injectionMap)
			{
				injectionData.dispose();
			}

			injectionMap = null;
		}

		/**
		 * @inheritDoc
		 */
		public function set autoInjectDependencies(value:Boolean):void
		{
			_autoInjectDependencies = value;
		}

		/**
		 * @inheritDoc
		 */
		public function set verbose(value:Boolean):void
		{
			_verbose = value;
		}
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

	internal function dispose():void
	{
		variables = null;
	}
}
