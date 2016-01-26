/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IMediator;
	import com.crazy.mvc.api.IView;

	import org.osflash.signals.Signal;

	public class Mediator implements IMediator
	{
		private var _signal:Signal;

		public function Mediator()
		{
		}

		public function addViewListener(eventType:String, handler:Function):void
		{
			if(!_signal)
			{
				_signal = new Signal();
			}

			_signal.add(handler);
		}

		public function removeViewListener(handler:Function):void
		{
			if(_signal)
			{
				_signal.remove(handler);
			}
		}
	}
}
