/**
 * Created by Anton Nefjodov on 28.01.2016.
 */
package com.crazyfm.core.mvc.event
{
	import org.osflash.signals.events.GenericEvent;

	/**
	 * Event that is dispatched with signal.
	 */
	public class SignalEvent extends GenericEvent implements ISignalEvent
	{
		private var _data:Object;
		private var _type:String;
		private var _isDisposed:Boolean;

		public function SignalEvent(type:String, data:Object = null)
		{
			super(true);

			_type = type;
			_data = data;
		}

		/**
		 * @inheritDoc
		 */
		public function get data():Object
		{
			return _data;
		}

		/**
		 * @inheritDoc
		 */
		public function get type():String
		{
			return _type;
		}

		internal function setData(value:Object):void
		{
			_data = value;
		}

		internal function setType(value:String):void
		{
			_type = value;
		}

		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			_data = null;
			_target = null;
			_currentTarget = null;
			_isDisposed = true;
		}

		/**
		 * @inheritDoc
		 */
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
	}
}
