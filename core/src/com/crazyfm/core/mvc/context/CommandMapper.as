/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.ns_app_factory;
	import com.crazyfm.core.mvc.command.*;

	import flash.utils.Dictionary;

	use namespace ns_app_factory;

	/**
	 * Maps specific signals to <code>ICommand</code>.
	 */
	public class CommandMapper implements ICommandMapper
	{
		private var commandMap:Dictionary/*Enum, Vector.<Class>*/ = new Dictionary();
		private var factory:AppFactory;

		public function CommandMapper(factory:AppFactory)
		{
			super();

			this.factory = factory;
		}

		public function map(signalType:Enum, commandClass:Class):ICommandMapper
		{
			if (!commandMap[signalType])
			{
				commandMap[signalType] = new <Class>[commandClass];
			}else
			if (commandMap[signalType].indexOf(commandClass) == -1){
				commandMap[signalType].push(commandClass);
			}

			return this;
		}

		public function unmap(signalType:Enum, commandClass:Class):ICommandMapper
		{
			if (commandMap[signalType])
			{
				var index:int = commandMap[signalType].indexOf(commandClass);
				if (index != -1)
				{
					commandMap[signalType].removeAt(index);

					if (commandMap[signalType].length == 0)
					{
						commandMap[signalType] = null;

						delete commandMap[signalType];
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

		public function tryToExecuteCommand(signalType:Enum):void
		{
			var mappedToSignalCommands:Vector.<Class> = commandMap[signalType];
			var command:ICommand;

			if (mappedToSignalCommands != null)
			{
				for each (var commandClass:Class in mappedToSignalCommands)
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

		public function unmapAll(signalType:Enum):ICommandMapper
		{
			if (commandMap[signalType])
			{
				commandMap[signalType] = null;

				delete commandMap[signalType];
			}

			return this;
		}

		public function hasMapping(signalType:Enum):Boolean
		{
			return commandMap[signalType] != null;
		}
	}
}
