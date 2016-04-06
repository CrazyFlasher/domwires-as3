/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.mvc.event.ISignalDispatcher;

	/**
	 * Object, that part of hierarchy. Can dispatch and receive signals from hierarchy branch.
	 */
	public interface IHierarchyObject extends ISignalDispatcher
	{
		/**
		 * Returns parent object.
		 */
		function get parent():IHierarchyObjectContainer;
	}
}
