/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc.view
{
	import com.crazyfm.core.mvc.model.HierarchyObject;

	import flash.display.DisplayObjectContainer;

	/**
	 * Object that can be connected to IContext for further model <-> view communication via signals or direct
	 * connection. Dispatches signals to connected IContext. Can contain reference to DisplayObjectContainer.
	 */
	public class ViewController extends HierarchyObject implements IViewController
	{
		protected var _container:DisplayObjectContainer;

		/**
		 * Constructs new view controller object, that is used to work with flash display list objects.
		 * @param container
		 */
		public function ViewController(container:DisplayObjectContainer)
		{
			super();

			_container = container;
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			_container = null;

			super.dispose();
		}
	}
}