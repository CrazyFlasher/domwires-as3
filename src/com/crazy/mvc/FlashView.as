/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IView;

	import flash.display.DisplayObjectContainer;

	public class FlashView extends SignalDispatcher implements IView
	{
		public function FlashView(displayObjectContainer:DisplayObjectContainer)
		{
			super();
		}
	}
}
