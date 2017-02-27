/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.domwires.core.mvc.command
{
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
		public function map(messageType:Enum, commandClass:Class, data:Object = null, once:Boolean = false):MappingConfig
		{
			var mappingConfig:MappingConfig = new MappingConfig(commandClass, data, once);
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
							 once:Boolean = false):MappingConfigList
		{
			var commandClass:Class;
			var mappingConfigList:MappingConfigList = new MappingConfigList();

			for each (commandClass in commandClassList)
			{
				mappingConfigList.push(map(messageType, commandClass, data, once));
			}

			return mappingConfigList;
		}

		/**
		 * @inheritDoc
		 */
		public function map2(messageTypeList:Vector.<Enum>, commandClass:Class,
							 data:Object = null, once:Boolean = false):MappingConfigList
		{
			var messageType:Enum;
			var mappingConfigList:MappingConfigList = new MappingConfigList();

			for each (messageType in messageTypeList)
			{
				mappingConfigList.push(map(messageType, commandClass, data, once));
			}

			return mappingConfigList;
		}

		/**
		 * @inheritDoc
		 */
		public function map3(messageTypeList:Vector.<Enum>, commandClassList:Vector.<Class>,
							 data:Object = null, once:Boolean = false):MappingConfigList
		{
			var commandClass:Class;
			var messageType:Enum;
			var mappingConfigList:MappingConfigList = new MappingConfigList();
			
			for each (commandClass in commandClassList)
			{
				for each (messageType in messageTypeList)
				{
					mappingConfigList.push(map(messageType, commandClass, data, once));
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
				guards = factory.getSingleton(guardClass) as IGuards;

				if (data != null)
				{
					mapValues(data, true);
				}

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
			var command:ICommand = factory.getSingleton(commandClass) as ICommand;

			if (data != null)
			{
				mapValues(data, true);
			}

			factory.injectDependencies(command);

			command.execute();

			if (data != null)
			{
				mapValues(data, false);
			}
		}

		private function mapValues(data:Object, map:Boolean):void
		{
			var propertyName:*;
			var propertyValue:*;

			for (propertyName in data)
			{
				propertyValue = data[propertyName];
				if (map)
				{
					factory.mapToValue(getPropertyType(propertyValue), propertyValue, propertyName);
				}else
				{
					factory.unmapValue(getPropertyType(propertyValue), propertyName);
				}
			}
		}

		private static function getPropertyType(propertyValue:*):*
		{
			if (propertyValue is int) return int;
			if (propertyValue is uint) return uint;
			if (propertyValue is Number) return Number;
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