/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.command
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.Model;

	import flash.utils.Dictionary;

	public class CommandMapper extends Model implements ICommandMapper
	{
		private var commandMap:Dictionary/*Enum, CommandMappingVo*/ = new Dictionary();
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
				commandMap[signalType] = new CommandMappingVo(signalType, commandClass);
			}

			return this;
		}

		public function unmap(signalType:Enum, commandClass:Class):ICommandMapper
		{
			if (commandMap[signalType])
			{
				delete commandMap[signalType];
			}

			return this;
		}

		public function clear():ICommandMapper
		{
			commandMap = new Dictionary();

			return this;
		}

		public function handleSignal(event:ISignalEvent):ICommandMapper
		{
			if (commandMap[event.type])
			{
				var command:ICommand = factory.getInstance(commandMap[event.type]);
				command.execute();
			}

			return this;
		}


		override public function dispose():void
		{
			clear();

			super.dispose();
		}
	}
}

import com.crazyfm.core.common.Enum;

internal class CommandMappingVo {

	private var _signalType:Enum;
	private var _commandClass:Class;

	public function CommandMappingVo(signalType:Enum, commandClass:Class)
	{
		_signalType = signalType;
		_commandClass = commandClass;
	}

	public function get signalType():Enum
	{
		return _signalType;
	}

	public function get commandClass():Class
	{
		return _commandClass;
	}
}
