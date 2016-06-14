/**
 * Created by Anton Nefjodov on 14.06.2016.
 */
package com.crazyfm.devkit.timer
{
	import starling.animation.DelayedCall;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.events.EventDispatcher;

	public class Timer extends EventDispatcher
	{
		private var _currentCount:int;
		private var _delay:Number;
		private var _repeatCount:int;
		private var _juggler:Juggler;
		private var delayedCall:DelayedCall;
		private var _running:Boolean;

		public function Timer(delay:Number, repeatCount:int = 0, juggler:Juggler = null)
		{
			super();

			if (juggler == null) {
				juggler = Starling.juggler;
			}

			if (isNaN(delay) || delay < 0) {
				throw new Error("StarlingTimer invalid delay value:", delay);
			}
			_delay = delay;
			_repeatCount = repeatCount;
			_juggler = juggler;
			_running = false;
		}

		public function get currentCount():int
		{
			return _currentCount;
		}

		public function get delay():Number
		{
			return _delay;
		}

		public function set delay(value:Number):void
		{
			if (isNaN(value) || value < 0) {
				throw new Error("StarlingTimer invalid delay value:", value);
			}
			_delay = value;
		}

		public function get repeatCount():int
		{
			return _repeatCount;
		}

		public function set repeatCount(value:int):void
		{
			_repeatCount = value;
		}

		public function get running():Boolean
		{
			return _running;
		}

		public function reset():void
		{
			if (_running) {
				stop();
				_juggler.remove(delayedCall);
				_currentCount = 0;
			}
		}

		public function start():void
		{
			if (delayedCall == null) {
				delayedCall = new DelayedCall(onTimerTick, _delay / 1000);
			}else
			{
				delayedCall.reset(onTimerTick, _delay / 1000);
			}
			_juggler.add(delayedCall);
			_running = true;
		}

		public function stop():void
		{
			_running = false;
			_juggler.remove(delayedCall);
		}

		private function onTimerTick():void
		{

			var dispatchTimerEvent:Boolean = true;

			_currentCount ++;
			if (_repeatCount == 0 || _repeatCount - _currentCount > 0 ) {
				if (delayedCall == null) {
					delayedCall = new DelayedCall(onTimerTick, _delay / 1000);
				}else
				{
					delayedCall.reset(onTimerTick, _delay / 1000);
				}
				_juggler.add(delayedCall);
			} else {
				dispatchTimerEvent = false;
				onTimerComplete();
			}

			if (dispatchTimerEvent) {
				dispatchEventWith(TimerEvent.TIMER, true);
			}
		}

		private function onTimerComplete():void
		{
			_running = false;

			dispatchEventWith(TimerEvent.TIMER_COMPLETE, true);
		}
	}
}
