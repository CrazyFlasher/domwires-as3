/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.mvc.message.IMessageDispatcher;

	/**
	 * Object, that is a part of hierarchy. Can dispatch and receive messages from hierarchy branch.
	 */
	public interface IHierarchyObject extends IMessageDispatcher
	{
		/**
		 * Returns parent object.
		 */
		function get parent():IHierarchyObjectContainer;
	}
}
