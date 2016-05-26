/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.command
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface ICommandMapper extends IHierarchyObjectContainer
	{
		function map(signalType:Enum, commandClass:Class):ICommandMapper;
		function unmap(signalType:Enum, commandClass:Class):ICommandMapper;
	}
}
