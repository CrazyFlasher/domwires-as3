/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IDisposable;
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;

	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.events.IBubbleEventHandler;
	import org.osflash.signals.events.IEvent;

	public class Model implements IModel, IBubbleEventHandler, IDisposable
	{
		private var _parent:IModelContainer;
		private var _events:ISignal;

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

		public function dispose():void
		{
			_parent = null;

			if(_events)
			{
				_events.removeAll();
				_events = null;
			}
		}

		public function addModelEventListener(eventType:String, listener:Function, data:Object = null):void
		{
			if(!_events)
			{
				_events = new DeluxeSignal(this, IEvent, String, Object);
			}

			_events.add(listener);
		}

		public function dispatch(eventType:String, data:Object = null):void
		{
			if(!_events)
			{
				_events = new DeluxeSignal(this, IEvent, String, Object);
			}

			_events.dispatch(new GenericEvent(true), eventType, data);
		}

		public function removeModelEventListener(listener:Function):void
		{
			if(_events)
			{
				_events.remove(listener);
			}
		}

		public function get events():ISignal
		{
			if(!_events)
			{
				_events = new DeluxeSignal(this, IEvent, String, Object);
			}
			return _events;
		}

		public function onEventBubbled(event:IEvent):Boolean
		{
			return true;
		}
	}
}
