/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.core.mvc.command.*;

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

		public function CommandMapper()
		{
			super();
		}

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

		public function clear():ICommandMapper
		{
			commandMap = new Dictionary();

			return this;
		}

		public function tryToExecuteCommand(messageType:Enum):void
		{
			var mappedToMessageCommands:Vector.<Class> = commandMap[messageType];
			var command:ICommand;

			if (mappedToMessageCommands != null)
			{
				for each (var commandClass:Class in mappedToMessageCommands)
				{
					if (!factory.hasPoolForType(commandClass))
					{
						command = factory.getSingleton(commandClass) as ICommand;
						factory.injectDependencies(commandClass, command);
					}else
					{
						command = factory.getSingleton(commandClass) as ICommand;
					}

					command.execute();
					//TODO: async command
					command.retain();
				}
			}
		}

		public function unmapAll(messageType:Enum):ICommandMapper
		{
			if (commandMap[messageType])
			{
				commandMap[messageType] = null;

				delete commandMap[messageType];
			}

			return this;
		}

		public function hasMapping(messageType:Enum):Boolean
		{
			return commandMap[messageType] != null;
		}
	}
}
