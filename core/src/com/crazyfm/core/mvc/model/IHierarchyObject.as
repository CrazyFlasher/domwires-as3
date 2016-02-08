/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.mvc.model
{
	import com.crazyfm.core.mvc.event.ISignalDispatcher;

	public interface IHierarchyObject extends ISignalDispatcher
	{
		/**
		 * Returns parent object.
		 */
		function get parent():IHierarchyObject;
	}
}
