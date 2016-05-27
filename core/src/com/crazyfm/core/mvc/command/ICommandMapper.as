/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.command
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.IModel;

	public interface ICommandMapper extends IModel
	{
		function map(signalType:Enum, commandClass:Class):ICommandMapper;
		function unmap(signalType:Enum, commandClass:Class):ICommandMapper;
		function clear():ICommandMapper;
		function handleSignal(event:ISignalEvent):ICommandMapper;
	}
}
