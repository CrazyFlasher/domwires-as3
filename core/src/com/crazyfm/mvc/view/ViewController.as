/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.mvc.view
{
	import com.crazyfm.mvc.model.HierarchyObject;

	import flash.display.DisplayObjectContainer;

	/**
	 * Flash view object that can be connected to IContext for further model <-> view communication.
	 */
	public class ViewController extends HierarchyObject implements IViewController
	{
		protected var _container:DisplayObjectContainer;

		/**
		 * Constructs new view object, that is used to work with flash displayList objects.
		 * @param container
		 */
		public function ViewController(container:DisplayObjectContainer)
		{
			super();

			_container = container;
		}


	}
}
