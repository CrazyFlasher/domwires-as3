/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.view
{
	import com.crazyfm.core.mvc.model.IHierarchyObject;

	/**
	 * View controller object that can be connected to IContext for further model <-> view communication via signals or direct connection.
	 * Dispatches signals to connected IContext. Can contain reference to DisplayObjectContainer.
	 */
	public interface IViewController extends IHierarchyObject
	{

	}
}
