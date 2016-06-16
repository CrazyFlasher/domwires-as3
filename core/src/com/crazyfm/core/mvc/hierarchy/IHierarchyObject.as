/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.mvc.message.IMessageDispatcher;

	/**
	 * Object, that is a part of hierarchy. Can dispatch and receive messages from hierarchy branch.
	 * Because interfaces in AS3 do not support namespaces, implementation should also contain
	 * <code>ns_hierarchy function setParent(value:IHierarchyObjectContainer):void;</code>
	 */
	public interface IHierarchyObject extends IMessageDispatcher
	{
		/**
		 * Returns parent object.
		 */
		function get parent():IHierarchyObjectContainer;
	}
}
