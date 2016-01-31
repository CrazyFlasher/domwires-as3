/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IView;

	import flash.display.DisplayObjectContainer;

	/**
	 * Flash view object that can be connected to IContext for further model <-> view communication.
	 */
	public class FlashView extends SignalDispatcher implements IView
	{
		protected var _displayObjectContainer:DisplayObjectContainer;

		public function FlashView(displayObjectContainer:DisplayObjectContainer)
		{
			super();

			_displayObjectContainer = displayObjectContainer;
		}
	}
}
