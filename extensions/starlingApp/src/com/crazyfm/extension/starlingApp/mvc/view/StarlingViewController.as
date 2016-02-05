/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.extension.starlingApp.mvc.view
{
	import com.crazyfm.mvc.event.SignalDispatcher;
	import com.crazyfm.mvc.view.IViewController;

	import starling.display.DisplayObjectContainer;

	/**
	 * Starling view object that can be connected to IContext for further model <-> view communication.
	 */
	public class StarlingViewController extends SignalDispatcher implements IViewController
	{
		protected var _displayObjectContainer:DisplayObjectContainer;

		/**
		 * Constructs new view object, that is used to work with starling displayList objects.
		 * @param displayObjectContainer
		 */
		public function StarlingViewController(displayObjectContainer:DisplayObjectContainer)
		{
			super();

			_displayObjectContainer = displayObjectContainer;
		}
	}
}
