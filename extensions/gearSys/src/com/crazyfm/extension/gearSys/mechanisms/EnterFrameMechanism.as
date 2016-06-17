/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.gearSys.mechanisms
{
	import com.crazyfm.extension.gearSys.AbstractGearSysMechanism;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class EnterFrameMechanism extends AbstractGearSysMechanism
	{
		private var time:Number;

		private var sprite:Sprite;

		public function EnterFrameMechanism(constantPassedTime:Number = NaN)
		{
			super(constantPassedTime);

			init();
		}

		private function init():void
		{
			sprite = new Sprite();
			sprite.addEventListener(Event.ENTER_FRAME, enterFrame);

			time = getTimer();
		}

		private function enterFrame(event:Event):void
		{
			var currentTime:Number = getTimer();
			var passedTime:Number = currentTime - time;
			time = currentTime;

			interact(passedTime / 1000);
		}

		override public function dispose():void
		{
			sprite.removeEventListener(Event.ENTER_FRAME, enterFrame);

			sprite = null;

			super.dispose();
		}
	}
}
