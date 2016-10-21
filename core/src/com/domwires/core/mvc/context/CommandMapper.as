/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.domwires.core.mvc.context
{
	import com.domwires.core.common.Enum;
	import com.domwires.core.factory.IAppFactory;
	import com.domwires.core.mvc.command.ICommand;
	import com.domwires.core.mvc.message.IMessage;

	import flash.utils.Dictionary;

	/**
	 * Maps specific messages to <code>ICommand</code>.
	 */
	public class CommandMapper implements ICommandMapper
	{
		/**
		 * @private
		 */
		[Autowired]
		public var factory:IAppFactory;

		private var commandMap:Dictionary/*Enum, Vector.<Class>*/ = new Dictionary();

		/**
		 * @inheritDoc
		 */
		public function CommandMapper()
		{
			super();
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
		public function map(messageType:Enum, commandClass:Class):ICommandMapper
		{
			if (!commandMap[messageType])
			{
				commandMap[messageType] = new <Class>[commandClass];
			}else
			if (commandMap[messageType].indexOf(commandClass) == -1){
				commandMap[messageType].push(commandClass);
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(messageType:Enum, commandClass:Class):ICommandMapper
		{
			if (commandMap[messageType])
			{
				var index:int = commandMap[messageType].indexOf(commandClass);
				if (index != -1)
				{
					commandMap[messageType].removeAt(index);

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
			var mappedToMessageCommands:Vector.<Class> = commandMap[messageType];
			if (mappedToMessageCommands != null)
			{
				for each (var commandClass:Class in mappedToMessageCommands)
				{
					executeCommand(commandClass, message.data);
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

			factory.injectDependencies(commandClass, command);

			command.execute();

			if (data != null)
			{
				mapValues(data, false);
			}
		}

		private function mapValues(messageData:Object, map:Boolean):void
		{
			var propertyName:*;
			var propertyValue:*;

			for (propertyName in messageData)
			{
				propertyValue = messageData[propertyName];
				if (map)
				{
					factory.mapToValue(Object(propertyValue).constructor, propertyValue, propertyName);
				}else
				{
					factory.unmapValue(Object(propertyValue).constructor, propertyName);
				}
			}
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