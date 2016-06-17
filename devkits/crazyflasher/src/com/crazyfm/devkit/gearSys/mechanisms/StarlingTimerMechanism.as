/**
 * Created by Anton Nefjodov on 14.06.2016.
 */
package com.crazyfm.devkit.gearSys.mechanisms
{
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.devkit.timer.Timer;
	import com.crazyfm.devkit.timer.TimerEvent;
	import com.crazyfm.extension.gearSys.AbstractGearSysMechanism;

	public class StarlingTimerMechanism extends AbstractGearSysMechanism
	{
		[Autowired]
		public var factory:IAppFactory;

		private var delay:Number;

		private var timer:Timer;

		public function StarlingTimerMechanism(delay:Number)
		{
			super();

			this.delay = delay;
		}

		[PostConstruct]
		public function init():void
		{
			timer = factory.getInstance(Timer, [delay * 1000]);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}

		private function onTimer():void
		{
			interact(delay);
		}

		override public function dispose():void
		{
			timer.reset();
			timer.removeEventListeners();
			timer = null;

			super.dispose();
		}
	}
}
