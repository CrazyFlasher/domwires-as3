/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc.view
{
	import com.crazy.mvc.event.SignalDispatcher;

	import flash.display.DisplayObjectContainer;

	/**
	 * Flash view object that can be connected to IContext for further model <-> view communication.
	 */
	public class FlashViewController extends SignalDispatcher implements IViewController
	{
		protected var _displayObjectContainer:DisplayObjectContainer;

		/**
		 * Constructs new view object, that is used to work with flash displayList objects.
		 * @param displayObjectContainer
		 */
		public function FlashViewController(displayObjectContainer:DisplayObjectContainer)
		{
			super();

			_displayObjectContainer = displayObjectContainer;
		}
	}
}
