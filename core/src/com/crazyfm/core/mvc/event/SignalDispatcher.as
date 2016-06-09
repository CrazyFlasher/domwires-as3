/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc.event
{
	import com.crazyfm.core.common.AbstractDisposable;
	import com.crazyfm.core.common.Enum;

	import flash.utils.Dictionary;

	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.events.IEvent;

	/**
	 * Common signal dispatcher. Can be used for listening and dispatching signals for views and models.
	 */
	public class SignalDispatcher extends AbstractDisposable implements ISignalDispatcher
	{
		private var _signals:Dictionary;/*Enum, ISignal*/
		private var _genericEvent:ISignalEvent;

		public function SignalDispatcher()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchSignal(type:Enum, data:Object = null, bubbles:Boolean = true):void
		{
			getSignal(type).dispatch(getGenericEvent(type, data, bubbles))
		}

		/**
		 * @inheritDoc
		 */
		public function addSignalListener(type:Enum, listener:Function):void
		{
//			getSignal(type).removeAll();
			getSignal(type).add(listener);
		}

		/**
		 * @inheritDoc
		 */
		public function hasSignalListener(type:Enum):Boolean
		{
			return _signals != null && _signals[type] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function removeSignalListener(type:Enum, listener:Function):void
		{
			if (_signals[type] != null)
			{
				_signals[type].remove(listener);
			}

			delete _signals[type];
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllSignalListeners():void
		{
			if (_signals)
			{
				for (var type:* in _signals)
				{
					_signals[type].removeAll();
				}

				_signals = null;
			}
		}

		/**
		 * Disposes objects and removes all signals.
		 */
		override public function dispose():void
		{
			removeAllSignalListeners();

			if (_genericEvent)
			{
				_genericEvent.dispose();
			}
			_genericEvent = null;

			super.dispose();
		}

		private function getSignalsList():Dictionary/*Enum, ISignal*/
		{
			if (!_signals)
			{
				_signals = new Dictionary();
			}

			return _signals;
		}

		private function getSignal(type:Enum):ISignal
		{
			if (getSignalsList()[type] == null)
			{
				getSignalsList()[type] = new DeluxeSignal(this, ISignalEvent);
			}

			return getSignalsList()[type];
		}

		private function getGenericEvent(type:Enum, data:Object = null, bubbles:Boolean = true):IEvent
		{
			if (!_genericEvent)
			{
				_genericEvent = new SignalEvent(type, data, bubbles);
			} else
			{
				(_genericEvent as SignalEvent).setType(type);
				(_genericEvent as SignalEvent).setData(data);
				_genericEvent.signal = null;
				_genericEvent.target = null;
				_genericEvent.currentTarget = null;
				_genericEvent.bubbles = bubbles;
			}

			return _genericEvent;
		}
	}
}
