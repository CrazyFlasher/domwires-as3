/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.domwires.core.mvc.command
{
	import avmplus.DescribeTypeJSON;

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

		/**
		 * @inheritDoc
		 */
		public function map(messageType:Enum, commandClass:Class, data:Object = null, once:Boolean = false, stopOnExecute:Boolean = false):MappingConfig
		{
			var mappingConfig:MappingConfig = new MappingConfig(commandClass, data, once, stopOnExecute);
			if (!commandMap[messageType])
			{
				commandMap[messageType] = new <MappingConfig>[mappingConfig];
			}else
			if (!mappingListContains(commandMap[messageType], commandClass)){
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
					return mappingVo;
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
					if (!mappingVo.guardList || (mappingVo.guardList && guardsAllow(mappingVo.guardList, injectionData)))
					{
						commandClass = mappingVo.commandClass;
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

		private function guardsAllow(guardList:Vector.<Class>, data:Object = null):Boolean
		{
			var guardClass:Class;
			var guards:IGuards;

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

				if (!guards.allows)
				{
					return false;
				}
			}

			return true;
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
				for each (propertyName in varNameList)
				{
					mapProperty(data, propertyName, map);
				}
			}
		}

		private function mapProperty(data:Object, propertyName:String, map:Boolean):void
		{
			var propertyValue:* = data[propertyName];

			if (map)
			{
				factory.mapToValue(getPropertyType(propertyValue), propertyValue, propertyName);
			}else
			{
				factory.unmapValue(getPropertyType(propertyValue), propertyName);
			}
		}

		private static function getPropertyType(propertyValue:*):*
		{
			//TODO: Issue with injecting Number if its value is integer
			if (propertyValue is int) return int;
			if (propertyValue is Number) return Number;
			if (propertyValue is uint) return uint;
			if (propertyValue is String) return String;
			if (propertyValue is Boolean) return Boolean;

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