/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem.mechanisms
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class EnterFrameMechanism extends AbstractMechanism
	{
		private var time:Number;

		private var sprite:Sprite;

		public function EnterFrameMechanism()
		{
			super();

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

			interact(passedTime);
		}

		override public function dispose():void
		{
			sprite.removeEventListener(Event.ENTER_FRAME, enterFrame);
			sprite = null;

			super.dispose();
		}
	}
}
