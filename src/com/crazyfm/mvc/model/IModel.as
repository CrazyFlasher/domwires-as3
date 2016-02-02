/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.mvc.model
{
	import com.crazyfm.mvc.event.ISignalDispatcher;

	/**
	 * Model object that can be used for working with data and other logical non-view operations.
	 */
	public interface IModel extends ISignalDispatcher
	{
		/**
		 * Returns parent object.
		 */
		function get parent():IModelContainer;
	}
}
