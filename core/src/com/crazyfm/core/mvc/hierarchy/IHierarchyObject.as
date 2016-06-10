/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.mvc.event.ISignalDispatcher;
	import com.crazyfm.core.mvc.event.ISignalEvent;

	/**
	 * Object, that is a part of hierarchy. Can dispatch and receive signals from hierarchy branch.
	 */
	public interface IHierarchyObject extends ISignalDispatcher
	{
		/**
		 * Returns parent object.
		 */
		function get parent():IHierarchyObjectContainer;

		/**
		 * Manually pass signal.
		 * @param signal
		 */
		function handleSignal(signal:ISignalEvent):void;
	}
}
