/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IDisposable;
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;
	import com.crazy.mvc.api.ISignalEvent;

import flash.utils.Dictionary;

import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.events.IBubbleEventHandler;
	import org.osflash.signals.events.IEvent;

	public class Model implements IModel
	{
		private var _parent:IModelContainer;
		private var _signals:Dictionary/*String, ISignal*/
		private var _genericEvent:ISignalEvent;
		private var _isDisposed:Boolean;

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
			var event:IEvent = getGenericEvent(type, data);
			getSignal(type).dispatch(getGenericEvent(type, data))
		}

		public function addSignalListener(type:String, listener:Function):void
		{
			getSignal(type).removeAll();
			getSignal(type).add(listener);
		}

		public function hasSignalListener(type:String):Boolean
		{
			return _signals != null && _signals[type] != null;
		}

		public function removeSignalListener(type:String):void
		{
			if (_signals[type] != null)
			{
				_signals[type].removeAll();
			}

			delete _signals[type];
		}

		public function removeAllSignals():void
		{
			if(_signals)
			{
				for (var type:String in _signals) {
					_signals[type].removeAll();
				}

				_signals = null;
			}
		}

		public function dispose():void
		{
			_parent = null;

			removeAllSignals();

			_genericEvent = null;
			_isDisposed = true;
		}

		private function getSignalsList():Dictionary/*String, ISignal*/
		{
			if(!_signals)
			{
				_signals = new Dictionary();
			}

			return _signals;
		}

		private function getSignal(type:String):ISignal {
			if (getSignalsList()[type] == null)
			{
				getSignalsList()[type] = new DeluxeSignal(this, ISignalEvent);
			}

			return getSignalsList()[type];
		}

		private function getGenericEvent(type:String, data:Object = null):IEvent
		{
			if(!_genericEvent)
			{
				_genericEvent = new SignalEvent(type, data);
			}else
			{
				_genericEvent.type = type;
				_genericEvent.data = data;
			}

			return _genericEvent;
		}

		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
	}
}
