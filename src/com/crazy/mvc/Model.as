/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IDisposable;
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;
	import com.crazy.mvc.api.ISignalEvent;

	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.events.IBubbleEventHandler;
	import org.osflash.signals.events.IEvent;

	public class Model implements IModel, IDisposable
	{
		private var _parent:IModelContainer;
		private var _signals:ISignal;
		private var _genericEvent:ISignalEvent;

		public function Model()
		{
		}

		public function set parent(value:IModelContainer):void
		{
			_parent = value;
		}

		public function get parent():IModelContainer
		{
			return _parent;
		}

		public function dispatchSignal(type:String, data:Object = null):void
		{
			getSignals().dispatch(getGenericEvent(type, data))
		}

		public function addSignalListener(listener:Function):void
		{
			getSignals().add(listener);
		}

		public function removeSignalListener(listener:Function):void
		{
			getSignals().remove(listener);
		}

		public function removeSignalsListeners():void
		{
			getSignals().removeAll();
		}

		public function dispose():void
		{
			_parent = null;

			if(_signals)
			{
				_signals.removeAll();
				_signals = null;
			}

			_genericEvent = null;
		}

		private function getSignals():ISignal
		{
			if(!_signals)
			{
				_signals = new DeluxeSignal(this, ISignalEvent);
			}

			return _signals;
		}

		private function getGenericEvent(type:String, data:Object = null):IEvent
		{
			if(!_genericEvent)
			{
				_genericEvent = new SignalEvent(type, data);
			}

			return _genericEvent;
		}

		public function get signals():ISignal
		{
			return _signals;
		}
	}
}
