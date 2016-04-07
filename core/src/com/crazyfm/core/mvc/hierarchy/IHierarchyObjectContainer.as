/**
 * Created by Anton Nefjodov on 6.04.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.common.Enum;

	import org.osflash.signals.events.IBubbleEventHandler;

	use namespace ns_hierarchy;

	public interface IHierarchyObjectContainer extends IHierarchyObject, IBubbleEventHandler
	{
		function add(child:IHierarchyObject):IHierarchyObjectContainer;

		function remove(child:IHierarchyObject, dispose:Boolean = false):IHierarchyObjectContainer;

		function removeAll(dispose:Boolean = false):IHierarchyObjectContainer;

		function disposeWithAllChildren():void;

		function dispatchSignalToChildren(type:Enum, data:Object = null):void;
	}
}
