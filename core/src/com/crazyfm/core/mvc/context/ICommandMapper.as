/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.model.IModel;

	internal interface ICommandMapper extends IModel
	{
		function map(signalType:Enum, commandClass:Class):ICommandMapper;
		function unmap(signalType:Enum, commandClass:Class):ICommandMapper;
		function clear():ICommandMapper;
		function unmapAll(signalType:Enum):ICommandMapper;
		function hasMapping(signalType:Enum):Boolean;
	}
}
