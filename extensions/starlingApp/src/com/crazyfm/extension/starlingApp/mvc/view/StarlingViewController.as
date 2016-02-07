/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.extension.starlingApp.mvc.view
{
	import com.crazyfm.mvc.model.HierarchyObject;
	import com.crazyfm.mvc.view.IViewController;

	import starling.display.DisplayObjectContainer;

	/**
	 * Starling view object that can be connected to IContext for further model <-> view communication.
	 */
	public class StarlingViewController extends HierarchyObject implements IViewController
	{
		protected var _container:DisplayObjectContainer;

		/**
		 * Constructs new view object, that is used to work with starling displayList objects.
		 * @param container
		 */
		public function StarlingViewController(container:DisplayObjectContainer)
		{
			super();

			_container = container;
		}
	}
}
