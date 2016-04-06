/**
 * Created by Anton Nefjodov on 6.04.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.common.Enum;

	public interface IHierarchyObjectContainer extends IHierarchyObject
	{
		/**
		 * Adds model to model list of current object.
		 * @param child
		 */
		function add(child:IHierarchyObject):IHierarchyObjectContainer;

		/**
		 * Removes object from children list of current object.
		 * @param child
		 * @param dispose
		 */
		function remove(child:IHierarchyObject, dispose:Boolean = false):IHierarchyObjectContainer;

		/**
		 * Removes all children from children list of current object.
		 * @param dispose If true, then removed children will be disposed
		 * @param withChildren If true, children of disposed object will be disposed also
		 */
		function removeAll(dispose:Boolean = false):IHierarchyObjectContainer;

		/**
		 * Returns number of added models to model list of current object.
		 */
		function get childrenCount():int;

		/**
		 * Returns true if current object contains this object.
		 * @param child
		 * @return true, if object contains value
		 */
		function contains(child:IHierarchyObject):Boolean;

		/**
		 * Disposes current object and disposes objects from its model list.
		 */
		function disposeWithAllChildren():void;

		/**
		 * Returns children objects.
		 */
		function get children():Vector.<IHierarchyObject>;

		/**
		 * Dispatches signal down to hierarchy.
		 * @param type Signal type
		 * @param data Optional data that will sent with signal
		 */
		function dispatchSignalToChildren(type:Enum, data:Object = null):void;
	}
}
