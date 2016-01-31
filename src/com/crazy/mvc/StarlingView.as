/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IView;

	import starling.display.DisplayObjectContainer;

	public class StarlingView extends SignalDispatcher implements IView
	{
		public function StarlingView(displayObjectContainer:DisplayObjectContainer)
		{
			super();
		}
	}
}
