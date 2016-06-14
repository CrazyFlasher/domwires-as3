/**
 * Created by Anton Nefjodov on 14.06.2016.
 */
package com.crazyfm.devkit.timer
{
	import starling.events.Event;

	public class TimerEvent extends Event
	{
		public static const TIMER:String = "starlingTimer";
		public static const TIMER_COMPLETE:String = "starlingTimerComplete";

		public function TimerEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
