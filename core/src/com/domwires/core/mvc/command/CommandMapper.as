/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.domwires.core.mvc.command
{
	import avmplus.DescribeTypeJSON;
	import avmplus.getQualifiedClassName;

	import com.domwires.core.common.AbstractDisposable;
	import com.domwires.core.common.Enum;
	import com.domwires.core.factory.IAppFactory;
	import com.domwires.core.mvc.message.IMessage;

	import flash.utils.Dictionary;

	/**
	 * @see com.domwires.core.mvc.command.ICommandMapper
	 */
	public class CommandMapper extends AbstractDisposable implements ICommandMapper
	{
		private static const describeTypeJSON:DescribeTypeJSON = new DescribeTypeJSON();
		private var instanceDescriptionMap:Dictionary/*Class, Vector.<String>*/ = new Dictionary();

		/**
		 * <b>[Autowired]</b>
		 */
		[Autowired]
		public var factory:IAppFactory;

		private var commandMap:Dictionary/*Enum, Vector.<MappingVo>*/ = new Dictionary();

		private var _verbose:Boolean;
		private var mappingToKeepAfterExecutionList:Vector.<TypeAndNameVo>;

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			clear();

			instanceDescriptionMap = null;
			commandMap = null;
			factory = null;

			super.dispose();
		}

		/**
		 * @private
		 */
		[PostConstruct]
		public function init():void
		{
			factory.mapToValue(ICommandMapper, this);
		}

		public function set verbose(value:Boolean):void
		{
			_verbose = value;
		}

		/**
		 * @inheritDoc
		 */
		public function map(messageType:Enum, commandClass:Class, data:Object = null, once:Boolean = false, stopOnExecute:Boolean = false):MappingConfig
		{
			var mappingConfig:MappingConfig = new MappingConfig(commandClass, data, once, stopOnExecute);
			if (!commandMap[messageType])
			{
				commandMap[messageType] = new <MappingConfig>[mappingConfig];
			} else
			if (!mappingListContains(commandMap[messageType], commandClass))
			{
				commandMap[messageType].push(mappingConfig);
			}

			return mappingConfig;
		}

		/**
		 * @inheritDoc
		 */
		public function map1(messageType:Enum, commandClassList:Vector.<Class>, data:Object = null,
							 once:Boolean = false, stopOnExecute:Boolean = false):MappingConfigList
		{
			var commandClass:Class;
			var mappingConfigList:MappingConfigList = new MappingConfigList();

			for each (commandClass in commandClassList)
			{
				var soe:Boolean = stopOnExecute && commandClassList.indexOf(commandClass) == commandClassList.length - 1;
				mappingConfigList.push(map(messageType, commandClass, data, once, soe));
			}

			return mappingConfigList;
		}

		/**
		 * @inheritDoc
		 */
		public function map2(messageTypeList:Vector.<Enum>, commandClass:Class,
							 data:Object = null, once:Boolean = false, stopOnExecute:Boolean = false):MappingConfigList
		{
			var messageType:Enum;
			var mappingConfigList:MappingConfigList = new MappingConfigList();

			for each (messageType in messageTypeList)
			{
				var soe:Boolean = stopOnExecute && messageTypeList.indexOf(messageType) == messageTypeList.length - 1;
				mappingConfigList.push(map(messageType, commandClass, data, once, soe));
			}

			return mappingConfigList;
		}

		/**
		 * @inheritDoc
		 */
		public function map3(messageTypeList:Vector.<Enum>, commandClassList:Vector.<Class>,
							 data:Object = null, once:Boolean = false, stopOnExecute:Boolean = false):MappingConfigList
		{
			var commandClass:Class;
			var messageType:Enum;
			var mappingConfigList:MappingConfigList = new MappingConfigList();
			
			for each (commandClass in commandClassList)
			{
				for each (messageType in messageTypeList)
				{
					var soe:Boolean = stopOnExecute
							&& messageTypeList.indexOf(messageType) == messageTypeList.length - 1
							&& commandClassList.indexOf(commandClass) == commandClassList.length - 1;

					mappingConfigList.push(map(messageType, commandClass, data, once, soe));
				}
			}

			return mappingConfigList;
		}

		private static function mappingListContains(list:Vector.<MappingConfig>, commandClass:Class):MappingConfig
		{
			var mappingVo:MappingConfig;
			for each (mappingVo in list)
			{
				if (mappingVo.commandClass == commandClass)
				{
					var hasGuards:Boolean = mappingVo.guardList && mappingVo.guardList.length > 0;
					return hasGuards ? null : mappingVo;
				}
			}

			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(messageType:Enum, commandClass:Class):ICommandMapper
		{
			if (commandMap[messageType])
			{
				var mappingVo:MappingConfig = mappingListContains(commandMap[messageType], commandClass);
				if (mappingVo)
				{
					commandMap[messageType].removeAt(commandMap[messageType].indexOf(mappingVo));

					if (commandMap[messageType].length == 0)
					{
						commandMap[messageType] = null;

						delete commandMap[messageType];
					}
				}
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function clear():ICommandMapper
		{
			commandMap = new Dictionary();
			mappingToKeepAfterExecutionList = null;

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function tryToExecuteCommand(message:IMessage):void
		{
			var messageType:Enum = message.type;
			var mappedToMessageCommands:Vector.<MappingConfig> = commandMap[messageType];
			if (mappedToMessageCommands != null)
			{
				var mappingVo:MappingConfig;
				var commandClass:Class;
				var injectionData:Object;
				for each (mappingVo in mappedToMessageCommands)
				{
					injectionData = message.data == null ? mappingVo.data : message.data;
					commandClass = mappingVo.commandClass;

					var logFailExecution:Boolean;
					var logSuccessExecution:Boolean;

					if (_verbose)
					{
						logFailExecution = this.logExecution(commandClass, false);
						logSuccessExecution = this.logExecution(commandClass, true);

						if (mappingVo.guardList && logFailExecution)
						{
							log("----------------------------------------------");
							log("Checking guards for '" + getQualifiedClassName(commandClass) + "'");
						}
					}

					if (!mappingVo.guardList || (mappingVo.guardList && guardsAllow(mappingVo.guardList, injectionData, logFailExecution)))
					{
						if (_verbose && logSuccessExecution)
						{
							log("Executing: '" + getQualifiedClassName(commandClass) + "'");
						}
						
						executeCommand(commandClass, injectionData);

						if (mappingVo.once)
						{
							unmap(messageType, commandClass);
						}
						if (mappingVo.stopOnExecute)
						{
							break;
						}
					}
				}
			}
		}

		private function logExecution(commandClass:Class, logSuccess:Boolean):Boolean
		{
			var methodName:String = logSuccess ? "LOG_EXECUTION_SUCCESS" : "LOG_EXECUTION_FAIL";

			if (!commandClass.hasOwnProperty(methodName))
			{
				return logSuccess;
			}

			return commandClass[methodName];
		}

		private function guardsAllow(guardList:Vector.<Class>, data:Object = null, logExecution:Boolean = false):Boolean
		{
			var guardClass:Class;
			var guards:IGuards;

			var guardsAllow:Boolean = true;

			for each (guardClass in guardList)
			{
				if (data != null)
				{
					mapValues(data, true);
				}

				guards = factory.getSingleton(guardClass) as IGuards;
				factory.injectDependencies(guards);

				if (data != null)
				{
					mapValues(data, false);
				}

				if (_verbose && logExecution)
				{
					log("Guards '" + getQualifiedClassName(guardClass) + "' allow: " + guards.allows);
				}

				if (!guards.allows)
				{
					if (_verbose && logExecution)
					{
						guardsAllow = false;
					} else
					{
						return false;
					}
				}
			}

			return guardsAllow;
		}

		/**
		 * @inheritDoc
		 */
		public function executeCommand(commandClass:Class, data:Object = null):void
		{
			if (data != null)
			{
				mapValues(data, true);
			}

			var command:ICommand = factory.getSingleton(commandClass) as ICommand;
			factory.injectDependencies(command);
			command.execute();

			if (data != null)
			{
				mapValues(data, false);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function keepDataMappingAfterExecution(type:Class, name:String):ICommandMapper
		{
			if (!mappingToKeepAfterExecutionList)
			{
				mappingToKeepAfterExecutionList = new <TypeAndNameVo>[];
			}

			var id:String = getQualifiedClassName(type) + "$" + name;

			mappingToKeepAfterExecutionList.push(new TypeAndNameVo(type, name));

			return this;
		}

		private function mapValues(data:Object, map:Boolean):void
		{
			var propertyName:String;

			var gotProps:Boolean;

			for (propertyName in data)
			{
				gotProps = true;

				mapProperty(data, propertyName, map);
			}

			//This is not a generic object
			if (!gotProps)
			{
				var clazz:Class = Object(data).constructor;
				var varNameList:Vector.<String> = getVarNameList(clazz);
				for each (propertyName in varNameList)
				{
					mapProperty(data, propertyName, map);
				}
			}
		}

		private function getVarNameList(clazz:Class):Vector.<String>
		{
			var varNameList:Vector.<String> = instanceDescriptionMap[clazz];
			
			if (varNameList == null)
			{
				varNameList = new <String>[];
				var dtJson:Object = describeTypeJSON.getInstanceDescription(clazz);
				var arr:Array = dtJson.traits.variables;
				if (dtJson.traits.accessors != null)
				{
					if (arr != null)
					{
						arr = arr.concat(dtJson.traits.accessors);
					} else
					{
						arr = dtJson.traits.accessors;
					}
				}
				if (arr != null)
				{
					for each (var varData:Object in arr)
					{
						varNameList.push(varData.name);
					}
					instanceDescriptionMap[clazz] = varNameList;
				}
			}
			
			return varNameList;
		}

		private function mapProperty(data:Object, propertyName:String, map:Boolean):void
		{
			var propertyValue:* = data[propertyName];
			var type:Class = getPropertyType(propertyValue);
			if (map)
			{
				factory.mapToValue(type, propertyValue, propertyName);
			}else
			{

				if (!mustBeKept(type, propertyName))
				{
					factory.unmapValue(type, propertyName);
				}
			}
		}

		private function mustBeKept(type:Class, propertyName:String):Boolean
		{
			if (!mappingToKeepAfterExecutionList)
			{
				return false;
			}

			for each (var vo:TypeAndNameVo in mappingToKeepAfterExecutionList)
			{
				if (vo.type == type && vo.name == propertyName)
				{
					return true;
				}
			}

			return false;
		}

		private static function getPropertyType(propertyValue:Object):Class
		{
			//TODO: Issue with injecting Number if its value is integer

			if (propertyValue is Number)
			{
				if (propertyValue is int) return int;
				if (propertyValue is uint) return uint;

				return Number;
			}

//			if (propertyValue is String) return String;
//			if (propertyValue is Boolean) return Boolean;

			return Object(propertyValue).constructor;
		}

		/**
		 * @inheritDoc
		 */
		public function unmapAll(messageType:Enum):ICommandMapper
		{
			if (commandMap[messageType])
			{
				commandMap[messageType] = null;

				delete commandMap[messageType];
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function hasMapping(messageType:Enum):Boolean
		{
			return commandMap[messageType] != null;
		}
	}
}

internal class TypeAndNameVo
{
	private var _type:Class;
	private var _name:String;

	public function TypeAndNameVo(type:Class, name:String)
	{
		_type = type;
		_name = name;
	}

	public function get type():Class
	{
		return _type;
	}

	public function get name():String
	{
		return _name;
	}
}