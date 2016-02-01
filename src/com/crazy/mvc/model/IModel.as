/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.model
{
	import com.crazy.mvc.common.IDisposable;

	/**
	 * Model object that can be used for working with data and other logical non-view operations
	 */
	public interface IModel extends IDisposable
	{
		/**
		 * Returns parent object
		 */
		function get parent():IModelContainer;
	}
}