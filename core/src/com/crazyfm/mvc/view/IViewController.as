/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.mvc.view
{
	import com.crazyfm.mvc.model.IHierarchyObject;

	/**
	 * Common view object that should contain either flash.display.DisplayObjectContainer or starling.display.DisplayObjectContainer.
	 * IView object connects to IContext for further communication.
	 */
	public interface IViewController extends IHierarchyObject
	{

	}
}
