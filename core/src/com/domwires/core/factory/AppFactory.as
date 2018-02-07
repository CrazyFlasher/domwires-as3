/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.domwires.core.factory
{
	import avmplus.DescribeTypeJSON;
	import avmplus.getQualifiedClassName;

	import com.domwires.core.common.AbstractDisposable;

	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	/**
	 * @see com.domwires.core.factory.IAppFactory
	 */
	public class AppFactory extends AbstractDisposable implements IAppFactory
	{
		private static const injectionMap:Dictionary = new Dictionary()/*Class, InjectionDataVo*/;
		private static const describeTypeJSON:DescribeTypeJSON = new DescribeTypeJSON();

		private var typeMapping:Dictionary = new Dictionary()/*Class, Class*/;
		private var instanceMapping:Dictionary = new Dictionary()/*Object, Class*/;
		private var pool:Dictionary = new Dictionary()/*Class, PoolModel*/;

		/**
		 * Automatically injects dependencies to newly created instances, using <code>getInstance</code> method.
		 */
		private var _autoInjectDependencies:Boolean = true;

		/**
		 * Prints out extra information to logs.
		 * Useful for debugging, but leaks performance.
		 */
		private var _verbose:Boolean = false;

		/**
		 * @inheritDoc
		 */
		public function mapToType(type:Class, to:Class):IAppFactory
		{
			if (to == null)
			{
				throw new Error("Cannot map type to null type!");
			}

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
			if (to == null)
			{
				throw new Error("Cannot map type to null value!");
			}

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
		public function hasTypeMappingForType(type:Class, name:String = null):Boolean
		{
			return typeMapping[type] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function hasValueMappingForType(type:Class, name:String = null):Boolean
		{
			var id:String = getId(type, name);

			return instanceMapping[id] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function unmapType(type:Class):IAppFactory
		{
			if(typeMapping[type] != null)
			{
				delete typeMapping[type];
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function unmapValue(type:Class, name:String = null):IAppFactory
		{
			var id:String = getId(type, name);

			if(instanceMapping[id] != null)
			{
				delete instanceMapping[id];
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function getInstanceFromPool(type:Class):*
		{
			var obj:* = getFromPool(type, null, false);

			if (!obj)  throw new Error("There are no objects in pool for " + type + "!");

			return obj;
		}

		/**
		 * @inheritDoc
		 */
		public function getInstance(type:Class, constructorArgs:* = null, name:String = null, ignorePool:Boolean = false):*
		{
			if (!name)
			{
				name = "";
			}

			var id:String = getId(type, name);
			
			var obj:* = getInstanceFromInstanceMap(id);

			if (obj) return obj;

			if (!ignorePool && hasPoolForType(type))
			{
				obj = getFromPool(type, constructorArgs);
			}else
			{
				obj = getNewInstance(type, constructorArgs);

				if (obj != null)
				{
					if (_autoInjectDependencies)
					{
						obj = injectDependencies(obj);
					}

					var injectionData:InjectionDataVo = getInjectionData(Object(obj).constructor);
					if (injectionData.postConstructName != null)
					{
						obj[injectionData.postConstructName]();
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

		internal function getNewInstance(type:Class, constructorArgs:* = null):*
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

				if (_verbose)
				{
					log("Warning: interface " + type + " is not mapped to any class. Trying to find default implementation " + defImplClassName);	
				}
				mapToType(type, getDefinitionByName(defImplClassName) as Class);

				return null;
			}
		}

		private static function returnNewInstance(type:Class, constructorArgs:* = null):*
		{
			if (!constructorArgs || (constructorArgs is Array && constructorArgs.length == 0))
			{
				return new type();
			}

			if (constructorArgs is Array)
			{
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

			return new type(constructorArgs);
		}

		/**
		 * @inheritDoc
		 */
		public function registerPool(type:Class, capacity:uint = 5, instantiateNow:Boolean = false, constructorArgs:* = null):IAppFactory
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

				if (instantiateNow)
				{
					for (var i:int = 0; i < capacity; i++)
					{
						getFromPool(type, constructorArgs);
					}
				}
			}

			return this;
		}

		private function getFromPool(type:Class, constructorArgs:* = null, createNewIfNeeded:Boolean = true):*
		{
			if (!pool[type])
			{
				throw new Error("Pool " + type + "is not registered! Call registerPool.");
			}

			return pool[type].get(type, constructorArgs, createNewIfNeeded);
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
		public function increasePoolCapacity(type:Class, additionalCapacity:int):IAppFactory
		{
			if (!hasPoolForType(type)) throw new Error("Pool " + type + "is not registered! Call registerPool.");

			pool[type].increaseCapacity(additionalCapacity);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function getPoolCapacity(type:Class):int
		{
			if (!hasPoolForType(type)) throw new Error("Pool " + type + "is not registered! Call registerPool.");

			return pool[type].capacity;
		}

		/**
		 * @inheritDoc
		 */
		public function getPoolInstanceCount(type:Class):int
		{
			if (!hasPoolForType(type)) throw new Error("Pool " + type + "is not registered! Call registerPool.");

			return pool[type].instanceCount;
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
		public function injectDependencies(instance:*):*
		{
			var instanceClass:Class = Object(instance).constructor;
			var injectionData:InjectionDataVo = getInjectionData(instanceClass);

			var objVar:String;
			var isOptional:Boolean;
			var qualifiedName:String;

			for (objVar in injectionData.variables)
			{
				isOptional = injectionData.variables[objVar].optional;
				qualifiedName = injectionData.variables[objVar].qualifiedName;
//				instance[objVar] = getAutowiredValue(injectionData.variables[objVar].qualifiedName, isOptional);
				try
				{
					instance[objVar] = getInstanceFromInstanceMap(qualifiedName, !isOptional);
				} catch (e:Error)
				{
					throw new Error("Cannot inject all required dependencies to '" + instanceClass + "'. Instance mapping for '" + qualifiedName + "' not" +
							" found!");
				}
			}

			if (injectionData.postInjectName != null)
			{
				instance[injectionData.postInjectName]();
			}

			return instance;
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
						if (injectionData.postConstructName && injectionData.postInjectName/* && injectionData.preDestroyName*/)
						{
							break;
						}else
						if (metadata.name == "PostConstruct")
						{
							injectionData.postConstructName = method.name;
						}else
						if (metadata.name == "PostInject")
						{
							injectionData.postInjectName = method.name;
						}/*else
						if (metadata.name == "PreDestroy")
						{
							injectionData.preDestroyName = method.name;
						}*/
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

		/**
		 * @inheritDoc
		 */
		public function appendMappingConfig(config:Dictionary/*DependencyVo*/):IAppFactory
		{
			var i:Class;
			var c:Class;
			var name:String;
			var interfaceDefinition:String;
			var d:DependencyVo;
			var splitted:Array;

			for (interfaceDefinition in config)
			{
				d = config[interfaceDefinition];

				splitted = interfaceDefinition.split("$");
				if (splitted.length > 1)
				{
					name = splitted[1];
					interfaceDefinition = splitted[0];
				}

				i = getDefinitionByName(interfaceDefinition) as Class;

				if (d.value != null)
				{
					mapToValue(i, d.value, name);
				}else
				{
					if(d.implementation){
						c = getDefinitionByName(d.implementation) as Class;

						log("Mapping '" + interfaceDefinition + "' to '" + c + "'");

						mapToType(i, c);
					}

					if (d.newInstance)
					{
						mapToValue(i, getNewInstance(i), name);
					}
				}

				name = null;
			}
			
			return this;
		}
	}
}

import flash.utils.Dictionary;

internal class InjectionDataVo
{
	internal var variables:Dictionary/*String, InjectionVariableVo*/ = new Dictionary();
	internal var postConstructName:String;
	internal var postInjectName:String;
//	internal var preDestroyName:String;

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