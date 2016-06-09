/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.factory
{
	import avmplus.DescribeTypeJSON;

	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	use namespace ns_app_factory;

	/**
	 * <p>Universal object factory.</p>
	 * <p>Features:</p>
	 * <ul>
	 * <li>New instances creation</li>
	 * <li>Pools creation</li>
	 * <li>Map interface (or any other class type) to class</li>
	 * <li>Inject dependencies to created objects</li>
	 * <li>Manage singletons</li>
	 * </ul>
	 * <p>Namespace <code>ns_app_factory</code> is used to avoid calls of dangerous methods, that can affect stability of application.</p>
	 * @example
	 * <listing version="3.0">
	 *     var factory:AppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //returns new instance of MyObject
	 *     var obj:IMyObject = factory.getInstance(IMyObject) as IMyObject;
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:AppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //returns singleton instance of MyObject. Creates if needed
	 *     var obj:IMyObject = factory.getSingleton(IMyObject) as IMyObject;
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:AppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //returns new instance of MyObject and passes new Camera() as constructor argument
	 *     var obj:IMyObject = factory.getInstance(IMyObject, new Camera()) as IMyObject;
	 *     ...
	 *     public class MyObject implements IMyObject
	 *     {
	 *     		public function MyObject(camera:Camera)
	 *     		{
	 *   		}
	 *     }
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     use namespace ns_app_factory;
	 *
	 *     var factory:AppFactory = new AppFactory();
	 *
	 * 	   //registers pool with maximum 2 elements
	 *     factory.registerPool(IMyObject, 2);
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //Creates (if still not created) and returns instance of MyObject from pool
	 *     var obj:IMyObject = factory.getInstance(IMyObject) as IMyObject;
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:AppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //maps ICamera interface to Camera class
	 *     factory.map(ICamera, Camera);
	 *
	 *     //returns new instance of MyObject and passes new Camera() as constructor argument
	 *     var obj:IMyObject = factory.getInstance(IMyObject) as IMyObject;
	 *     ...
	 *     public class MyObject implements IMyObject
	 *     {
	 *     		[Autowired]
	 *     		public var camera:ICamera; //object will be automatically injected
	 *
	 *     		public function MyObject()
	 *     		{
	 *   		}
	 *
	 *			[PostConstruct]
	 *			public function init():void
	 *			{
	 *				//will be called automatically after dependencies are injected (e.q. camera in this case)
	 *			}
	 *     }
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     use namespace ns_app_factory;
	 *
	 *     var factory:AppFactory = new AppFactory();
	 *
	 * 	   //registers pool with maximum 2 elements
	 *     factory.registerPool(IMyObject, 2);
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //Creates (if still not created) and returns instance of MyObject from pool
	 *     var obj:IMyObject = factory.getInstance(IMyObject) as IMyObject;
	 *     //Injects dependencies to object and calls method (if any), that is marked with [PostConstruct] metatag
	 *     factory.injectDependencies(IMyObject, obj);
	 * </listing>
	 */
	public class AppFactory
	{
		//TODO: profiler test
		private static var instance:AppFactory;

		/**
		 * Returns <code>AppFactory</code> singleton instance.
		 * @return
		 */
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

		/**
		 * Automatically injects dependencies to newly created objects, using <code>getInstance</code> method.
		 */
		public var autoInjectDependencies:Boolean = true;

		/**
		 * Prints out extra information to logs.
		 * Useful for debugging, but leaks performance.
		 */
		public var verbose:Boolean = false;

		/**
		 * Creates new instance.
		 */
		public function AppFactory()
		{

		}

		/**
		 * Maps one class (or interface) type to another.
		 * @param type Type, that has to be mapped to another type
		 * @param toType Type, that source type should be mapped to
		 * @return
		 */
		ns_app_factory function map(type:Class, toType:Class):AppFactory
		{
			if (verbose && typeMapping[type])
			{
				log("Warning: type " + type + " is mapped to " + typeMapping[type] + ". Remapping to " + toType);
			}
			typeMapping[type] = toType;

			return this;
		}

		/**
		 * Returns true, if <code>AppFactory</code> has mapping for current type.
		 * @param type Class or interface type
		 * @return
		 */
		public function hasMappingForType(type:Class):Boolean
		{
			return typeMapping[type] != null;
		}

		/**
		 * Unmap current type.
		 * @param type
		 * @see #map()
		 */
		ns_app_factory function unmap(type:Class):void
		{
			if(typeMapping[type])
			{
				delete typeMapping[type];
			}
		}

		/**
		 * Returns either new instance of class or instance from pool.
		 * In case of new instance, constructorArgs can be passed and dependencies will be automatically injected (if
		 * <code>autoInjectDependencies</code> is set to true). if object is taken from pool or <code>autoInjectDependencies</code> is
		 * false, then dependencies can be injected using
		 * <code>injectDependencies</code>
		 * @param type Type of instance to return
		 * @param constructorArgs constructor arguments
		 * @return
		 * @see #injectDependencies()
		 * @see #getFromPool()
		 */
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
		 * Registers pool for instances of provided type.
		 * @param type Type of object to register pool for
		 * @param capacity Maximum objects of current type in pool
		 * @return
		 */
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

		/**
		 * Unregisters and disposes pool for provided type.
		 * @param type Type of object to register pool for
		 * @return
		 */
		ns_app_factory function unregisterPool(type:Class):AppFactory
		{
			if(pool[type])
			{
				pool[type].dispose();

				delete pool[type];
			}

			return this;
		}

		/**
		 * Returns true, if <code>AppFactory</code> has registered pool for provided type.
		 * @param type
		 * @return
		 */
		public function hasPoolForType(type:Class):Boolean
		{
			return pool[type] != null;
		}

		/**
		 * Returns (creates in needed) singleton of provided type.
		 * @param type
		 * @return
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
		 * Removes singleton of provided type.
		 * @param type
		 * @return
		 */
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

		/**
		 * Clears all pools of current <code>AppFactory</code>.
		 * @return
		 */
		ns_app_factory function clearPools():AppFactory
		{
			for each (var poolModel:PoolModel in pool)
			{
				poolModel.dispose();
			}
			pool = new Dictionary();

			return this;
		}

		/**
		 * Clears of mappings of current <code>AppFactory</code>.
		 * @return
		 */
		ns_app_factory function clearMappings():AppFactory
		{
			typeMapping = new Dictionary();

			return this;
		}

		/**
		 * Clears of pools and mappings of current <code>AppFactory</code>.
		 * @return
		 */
		ns_app_factory function clear():AppFactory
		{
			clearPools();
			clearMappings();

			return this;
		}

		/**
		 * Inject dependencies to properties marked with [Autowired] to provided object and calls [PostConstruct] method if has any.
		 * @param type Type of provided object
		 * @param object Object to inject dependencies to
		 * @return
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
		ns_app_factory function dispose():void
		{
			typeMapping = null;

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
