/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import avmplus.getQualifiedClassName;

	import com.crazy.mvc.api.IDisposable;
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;

	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.ISignal;

	public class Model implements IModel, IDisposable
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
				_events = new DeluxeSignal(this, String, Object);
			}

			_events.add(listener);
		}

		public function dispatch(eventType:String, data:Object = null):void
		{
			if(_events)
			{
				_events.dispatch(eventType, data);
			}
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
				_events = new DeluxeSignal(this, String, Object);
			}
			return _events;
		}
	}
}
