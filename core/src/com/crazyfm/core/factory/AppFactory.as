/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.factory
{
	import avmplus.DescribeTypeJSON;
	import avmplus.getQualifiedClassName;

	import com.crazyfm.core.common.AbstractDisposable;

	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	/**
	 * @see IAppFactory
	 */
	public class AppFactory extends AbstractDisposable implements IAppFactory
	{
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
		public function mapToType(type:Class, to:Class):IAppFactory
		{
			if (_verbose && typeMapping[type])
			{
				log("Warning: type " + type + " is mapped to type " + typeMapping[type] + ". Remapping to " + to);
			}
			typeMapping[type] = to;

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function mapToValue(type:Class, to:Object, name:String = null):IAppFactory
		{
			var id:String = getId(type, name);

			if (_verbose && instanceMapping[id] != null)
			{
				log("Warning: type " + type + " is mapped to instance " + instanceMapping[id] + ". Remapping to " + to);
			}
			instanceMapping[id] = /*type is Boolean ? to.toString() : */to;

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function hasMappingForType(type:Class, name:String = null):Boolean
		{
			var id:String = getId(type, name);

			return typeMapping[type] != null || instanceMapping[id] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(type:Class, name:String = null):IAppFactory
		{
			//TODO: split unmap type and unmap value
			var id:String = getId(type, name);

			if(typeMapping[type])
			{
				delete typeMapping[type];
			}

			if(instanceMapping[id])
			{
				delete instanceMapping[id];
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function getInstance(type:Class, constructorArgs:Array = null):*
		{
			var id:String = getId(type, "");
			
			var obj:* = getInstanceFromInstanceMap(id);

			if (obj) return obj;

			if (hasPoolForType(type))
			{
				if (_verbose && constructorArgs && constructorArgs.length > 0)
				{
					log("Warning: type " + type + " has registered pool. Ignoring constructorArgs.");
				}

				//Do not inject dependencies automatically to object, that is taken from pool.
				//Call injectDependencies to inject manually.
				obj = getFromPool(type);
			}else
			{
				obj = getNewInstance(type, constructorArgs);

				if (obj != null)
				{
					if (_autoInjectDependencies)
					{
						obj = injectDependencies(type, obj);
					}
				}else
				{
					//in case of getNewInstance returned null, try again using default implementation.
					obj = getInstance(type, constructorArgs);
				}
			}

			return obj;
		}

		private function getInstanceFromInstanceMap(id:String, require:Boolean = false):*
		{
			if (instanceMapping[id] != null)
			{
				return instanceMapping[id];
			}

			if (require)
			{
				throw new Error("Instance mapping for " + id + " not found!");
			}

			return null;
		}

		internal function getNewInstance(type:Class, constructorArgs:Array = null):*
		{
			var t:Class;

			if (typeMapping[type] == null)
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

			try
			{
				return returnNewInstance(t, constructorArgs);
			}catch (e:VerifyError)
			{
				var defImplClassName:String = getQualifiedClassName(type).replace(/::I/g, ".");

				log("Warning: interface " + type + " is not mapped to any class. Trying to find default implementation " + defImplClassName);
				mapToType(type, getDefinitionByName(defImplClassName) as Class);

				return null;
			}
		}

		private function returnNewInstance(type:Class, constructorArgs:Array = null):*
		{
			if (!constructorArgs || (constructorArgs && constructorArgs.length == 0))
			{
				return new type();
			}

			//TODO: find better solution
			switch (constructorArgs.length)
			{
				case 1: return new type(constructorArgs[0]);
				case 2: return new type(constructorArgs[0], constructorArgs[1]);
				case 3: return new type(constructorArgs[0], constructorArgs[1], constructorArgs[2]);
				case 4: return new type(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3]);
				case 5: return new type(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4]);
				case 6: return new type(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5]);
				case 7: return new type(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6]);
				case 8: return new type(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7]);
				case 9: return new type(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8]);
				case 10: return new type(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8], constructorArgs[9]);
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
			var isOptional:Boolean;

			for (objVar in injectionData.variables)
			{
				isOptional = injectionData.variables[objVar].optional;
				object[objVar] = getInstanceFromInstanceMap(injectionData.variables[objVar].qualifiedName, !isOptional);
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
				var isOptional:Boolean;

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
							isOptional = getVariableIsOptional(metadata.value);

							injectionData.variables[variable.name] = new InjectionVariableVo(variable.type/*.replace(/::/g, ".")*/ +
							 getVariableMetaName(metadata.value), isOptional);
						}
					}
				}

				injectionMap[mappedType] = injectionData;
			}

			return injectionData;
		}

		private static function getVariableIsOptional(metaPropertyList:Array):Boolean
		{
			var optional:Boolean;
			for (var i:int = 0; i < metaPropertyList.length; i++)
			{
				if (metaPropertyList[i].key == "optional")
				{
					optional = (metaPropertyList[i].value == "true");
					break;
				}
			}

			return optional;
		}

		private static function getVariableMetaName(metaPropertyList:Array):String
		{
			var metaName:String = "";
			for (var i:int = 0; i < metaPropertyList.length; i++)
			{
				if (metaPropertyList[i].key == "name")
				{
					metaName = "$" + metaPropertyList[i].value;
					break;
				}
			}

			return metaName;
		}

		/**
		 * Clears all pools, mappings and injection data of current <code>AppFactory</code>.
		 */
		override public function dispose():void
		{
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

			super.dispose();
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

		private static function getId(type:Class, name:String):String
		{
			return getQualifiedClassName(type) + (!name ? "" : "$" + name);
		}
	}
}

import flash.utils.Dictionary;

internal class InjectionDataVo
{
	internal var variables:Dictionary/*String, InjectionVariableVo*/ = new Dictionary();
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

internal class InjectionVariableVo
{
	private var _qualifiedName:String;
	private var _optional:Boolean;

	public function InjectionVariableVo(qualifiedName:String, optional:Boolean)
	{
		_qualifiedName = qualifiedName;
		_optional = optional;
	}

	public function get qualifiedName():String
	{
		return _qualifiedName;
	}

	public function get optional():Boolean
	{
		return _optional;
	}
}