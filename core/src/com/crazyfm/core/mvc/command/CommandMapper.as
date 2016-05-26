/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.command
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainer;

	public class CommandMapper extends HierarchyObjectContainer implements ICommandMapper
	{
		public function CommandMapper()
		{
			super();
		}

		public function map(signalType:Enum, commandClass:Class):ICommandMapper
		{
			add(new CommandMappingVo(signalType, commandClass));

			return this;
		}

		public function unmap(signalType:Enum, commandClass:Class):ICommandMapper
		{
			return this;
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
