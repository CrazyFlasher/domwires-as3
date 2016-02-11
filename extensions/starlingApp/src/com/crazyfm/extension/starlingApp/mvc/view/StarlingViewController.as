/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.extension.starlingApp.mvc.view
{
	import com.crazyfm.core.mvc.model.HierarchyObject;
	import com.crazyfm.core.mvc.view.IViewController;

	import starling.display.DisplayObjectContainer;

	/**
	 * Starling IViewController object that can be connected to IContext for further model <-> view communication via signals or direct
	 * connection. Dispatches signals to connected IContext. Can contain reference to DisplayObjectContainer.
	 */
	public class StarlingViewController extends HierarchyObject implements IViewController
	{
		protected var _container:DisplayObjectContainer;

		/**
		 * Constructs new view controller object, that is used to work with starling display list objects.
		 * @param container
		 */
		public function StarlingViewController(container:DisplayObjectContainer)
		{
			super();

			_container = container;
		}
	}
}
