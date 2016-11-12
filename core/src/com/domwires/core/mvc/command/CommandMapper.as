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
		 * @private
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
		public function map(messageType:Enum, commandClass:Class, data:Object = null, once:Boolean = false):ICommandMapper
		{
			if (!commandMap[messageType])
			{
				commandMap[messageType] = new <MappingVo>[new MappingVo(commandClass, data, once)];
			}else
			if (!mappingListContains(commandMap[messageType], commandClass)){
				commandMap[messageType].push(new MappingVo(commandClass, data, once));
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function mapMessageToCommandList(messageType:Enum, commandClassList:Vector.<Class>, data:Object = null,
												once:Boolean = false):ICommandMapper
		{
			var commandClass:Class;
			for each (commandClass in commandClassList)
			{
				map(messageType, commandClass, data, once);
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function mapMessageListToCommand(messageTypeList:Vector.<Enum>, commandClass:Class,
												data:Object = null, once:Boolean = false):ICommandMapper
		{
			var messageType:Enum;
			for each (messageType in messageTypeList)
			{
				map(messageType, commandClass, data, once);
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function mapMessageListToCommandList(messageTypeList:Vector.<Enum>, commandClassList:Vector.<Class>,
													data:Object = null, once:Boolean = false):ICommandMapper
		{
			var commandClass:Class;
			var messageType:Enum;
			for each (commandClass in commandClassList)
			{
				for each (messageType in messageTypeList)
				{
					map(messageType, commandClass, data, once);
				}
			}

			return this;
		}

		private static function mappingListContains(list:Vector.<MappingVo>, commandClass:Class):MappingVo
		{
			var mappingVo:MappingVo;
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
				var mappingVo:MappingVo = mappingListContains(commandMap[messageType], commandClass);
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
			var mappedToMessageCommands:Vector.<MappingVo> = commandMap[messageType];
			if (mappedToMessageCommands != null)
			{
				var mappingVo:MappingVo;
				var commandClass:Class;
				for each (mappingVo in mappedToMessageCommands)
				{
					commandClass = mappingVo.commandClass;
					executeCommand(commandClass, message.data == null ? mappingVo.data : message.data);

					if (mappingVo.once)
					{
						unmap(messageType, commandClass);
					}
				}
			}
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

internal class MappingVo
{
	private var _commandClass:Class;
	private var _data:Object;
	private var _once:Boolean;

	public function MappingVo(commandClass:Class, data:Object, once:Boolean)
	{
		_commandClass = commandClass;
		_data = data;
		_once = once;
	}

	public function get commandClass():Class
	{
		return _commandClass;
	}

	public function get once():Boolean
	{
		return _once;
	}

	public function get data():Object
	{
		return _data;
	}
}