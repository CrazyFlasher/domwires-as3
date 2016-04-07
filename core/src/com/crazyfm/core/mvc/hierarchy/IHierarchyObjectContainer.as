/**
 * Created by Anton Nefjodov on 6.04.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.common.Enum;

	use namespace ns_hierarchy;

	public interface IHierarchyObjectContainer extends IHierarchyObject
	{
		function add(child:IHierarchyObject):IHierarchyObjectContainer;

		function remove(child:IHierarchyObject, dispose:Boolean = false):IHierarchyObjectContainer;

		function removeAll(dispose:Boolean = false):IHierarchyObjectContainer;

		function disposeWithAllChildren():void;

		function dispatchSignalToChildren(type:Enum, data:Object = null):void;
	}
}
