/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.view
{
	import com.crazy.mvc.common.IDisposable;

	/**
	 * Common view object that should contain either flash.display.DisplayObjectContainer or starling.display.DisplayObjectContainer.
	 * IView object connects to IContext for further communication.
	 */
	public interface IViewController extends IDisposable
	{

	}
}
