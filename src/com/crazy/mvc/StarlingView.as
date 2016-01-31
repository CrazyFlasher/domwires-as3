/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IView;

	import starling.display.DisplayObjectContainer;

	/**
	 * Starling view object that can be connected to IContext for further model <-> view communication.
	 */
	public class StarlingView extends SignalDispatcher implements IView
	{
		protected var _displayObjectContainer:DisplayObjectContainer;

		public function StarlingView(displayObjectContainer:DisplayObjectContainer)
		{
			super();

			_displayObjectContainer = displayObjectContainer;
		}
	}
}
