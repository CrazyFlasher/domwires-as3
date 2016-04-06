/**
 * Created by Anton Nefjodov on 6.04.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.common.Enum;

	public interface IHierarchyObjectContainer extends IHierarchyObject
	{
		/**
		 * Adds object to object list of current object.
		 * @param child
		 * @param toList
		 */
		function add(child:IHierarchyObject, toList:Vector.<*> = null):IHierarchyObjectContainer;

		/**
		 * Removes object from children list of current object.
		 * @param child
		 * @param dispose
		 * @param fromList
		 */
		function remove(child:IHierarchyObject, dispose:Boolean = false, fromList:Vector.<*> = null):IHierarchyObjectContainer;

		/**
		 * Removes all children from all lists of current object.
		 * @param dispose If true, then removed children will be disposed
		 * @param fromList If true, then removed children will be disposed
		 */
		function removeAll(dispose:Boolean = false, fromList:Vector.<*> = null):IHierarchyObjectContainer;

		/**
		 * Disposes current object and disposes objects from its object list.
		 */
		function disposeWithAllChildren():void;

		/**
		 * Dispatches signal down to hierarchy.
		 * @param type Signal type
		 * @param data Optional data that will sent with signal
		 * @param inList
		 */
		function dispatchSignalToChildren(type:Enum, data:Object = null, inList:Vector.<*> = null):void;
	}
}
