/**
 * Created by Anton Nefjodov on 10.06.2016.
 */
package com.crazyfm.core.mvc.event
{
	import com.crazyfm.core.common.AbstractDisposable;
	import com.crazyfm.core.common.Enum;

	import flash.utils.Dictionary;

	public class SignalDispatcher2 extends AbstractDisposable implements ISignalDispatcher
	{
		private var _signalMap:Dictionary/*Enum, Vector.<Function>*/;
		private var _signal:ISignal;

		public function SignalDispatcher2()
		{
			super();
		}

		public function addSignalListener(type:Enum, listener:Function):void
		{
			if (!_signalMap)
			{
				_signalMap = new Dictionary();
			}

			if (!_signalMap[type])
			{
				_signalMap[type] = new <Function>[];
			}
			_signalMap[type].push(listener);
		}

		public function removeSignalListener(type:Enum, listener:Function):void
		{
			if (_signalMap)
			{
				if (_signalMap[type])
				{
					_signalMap[type].removeAt(_signalMap[type].indexOf(listener));
					if (_signalMap[type].length == 0)
					{
						delete _signalMap[type];
					}
				}
			}
		}

		public function removeAllSignalListeners():void
		{
			if (_signalMap)
			{
				for each (var v:Vector.<Function> in _signalMap)
				{
					v.length = 0;
				}

				_signalMap = null;
			}
		}

		public function dispatchSignal(type:Enum, data:Object = null, bubbles:Boolean = true):void
		{
			if (_signalMap)
			{
				if (_signalMap[type])
				{
					for each (var listener:Function in _signalMap[type])
					{
						listener(getSignal(type, data, bubbles));
					}
				}
			}
		}

		public function hasSignalListener(type:Enum):Boolean
		{
			if (_signalMap)
			{
				return _signalMap[type] != null;
			}

			return false;
		}

		private function getSignal(type:Enum, data:Object, bubbles:Boolean):ISignal
		{
			if (!_signal)
			{
				_signal = new Signal(type, data, bubbles);
			}else
			{
				(_signal as Signal)._type = type;
				(_signal as Signal)._data = data;
				(_signal as Signal)._bubbles = bubbles;
			}

			return _signal;
		}
	}
}

import com.crazyfm.core.common.Enum;

internal interface ISignal
{
	function get type():Enum;
	function get data():Object;
	function get bubbles():Boolean;
}

internal class Signal implements ISignal
{
	internal var _type:Enum;
	internal var _data:Object;
	internal var _bubbles:Boolean;

	public function Signal(type:Enum, data:Object = null, bubbles:Boolean = true)
	{
		_type = type;
		_data = data;
		_bubbles = bubbles;
	}

	public function get type():Enum
	{
		return _type;
	}

	public function get data():Object
	{
		return _data;
	}

	public function get bubbles():Boolean
	{
		return _bubbles;
	}
}
