/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc.event
{
	import com.crazy.mvc.common.Disposable;

	import flash.utils.Dictionary;

	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.events.IEvent;

	/**
	 * Common signal dispatcher. Can be used for listening and dispatching signals for views and models
	 */
	public class SignalDispatcher extends Disposable implements ISignalDispatcher
	{
		private var _signals:Dictionary;/*String, ISignal*/
		private var _genericEvent:ISignalEvent;

		public function SignalDispatcher()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchSignal(type:String, data:Object = null):void
		{
			getSignal(type).dispatch(getGenericEvent(type, data))
		}

		/**
		 * @inheritDoc
		 */
		public function addSignalListener(type:String, listener:Function):void
		{
			getSignal(type).removeAll();
			getSignal(type).add(listener);
		}

		/**
		 * @inheritDoc
		 */
		public function hasSignalListener(type:String):Boolean
		{
			return _signals != null && _signals[type] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function removeSignalListener(type:String):void
		{
			if (_signals[type] != null)
			{
				_signals[type].removeAll();
			}

			delete _signals[type];
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllSignals():void
		{
			if (_signals)
			{
				for (var type:String in _signals)
				{
					_signals[type].removeAll();
				}

				_signals = null;
			}
		}

		/**
		 * Disposes objects and removes all signals
		 */
		override public function dispose():void
		{
			removeAllSignals();

			if (_genericEvent)
			{
				_genericEvent.dispose();
			}
			_genericEvent = null;

			super.dispose();
		}

		private function getSignalsList():Dictionary/*String, ISignal*/
		{
			if (!_signals)
			{
				_signals = new Dictionary();
			}

			return _signals;
		}

		private function getSignal(type:String):ISignal
		{
			if (getSignalsList()[type] == null)
			{
				getSignalsList()[type] = new DeluxeSignal(this, ISignalEvent);
			}

			return getSignalsList()[type];
		}

		private function getGenericEvent(type:String, data:Object = null):IEvent
		{
			if (!_genericEvent)
			{
				_genericEvent = new SignalEvent(type, data);
			} else
			{
				(_genericEvent as SignalEvent).setType(type);
				(_genericEvent as SignalEvent).setData(data);
				_genericEvent.signal = null;
				_genericEvent.target = null;
				_genericEvent.currentTarget = null;
			}

			return _genericEvent;
		}
	}
}
