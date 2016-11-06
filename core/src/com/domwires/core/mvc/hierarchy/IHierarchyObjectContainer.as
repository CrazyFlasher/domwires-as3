/**
 * Created by Anton Nefjodov on 6.04.2016.
 */
package com.domwires.core.mvc.hierarchy
{
	import com.domwires.core.mvc.hierarchy.IHierarchyObjectImmutable;
	import com.domwires.core.mvc.message.IBubbleMessageHandler;
	import com.domwires.core.mvc.message.IMessage;

	use namespace ns_hierarchy;

	/**
	 * Container of <code>IHierarchyObject</code>'s
	 */
	public interface IHierarchyObjectContainer extends IHierarchyObjectContainerImmutable, IHierarchyObject, IBubbleMessageHandler
	{
		/**
		 * Adds object to hierarchy. Object becomes a part of hierarchy branch.
		 * @param child
		 * @param index
		 * @return
		 */
		function add(child:IHierarchyObject, index:int = -1):IHierarchyObjectContainer;

		/**
		 * Removes object from hierarchy.
		 * @param child
		 * @param dispose
		 * @return
		 */
		function remove(child:IHierarchyObject, dispose:Boolean = false):IHierarchyObjectContainer;

		/**
		 * Removes all objects from hierarchy.
		 * @param dispose
		 * @return
		 */
		function removeAll(dispose:Boolean = false):IHierarchyObjectContainer;

		/**
		 * Disposes current container and its children.
		 */
		function disposeWithAllChildren():void;

		/**
		 * Sends message to children.
		 * @param message
		 * @return
		 */
		function dispatchMessageToChildren(message:IMessage):void;
	}
}
