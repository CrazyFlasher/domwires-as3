/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.devkit.goSystem.mechanisms
{
	import com.crazyfm.extension.goSystem.AbstractGOSystemMechanism;

	import starling.animation.IAnimatable;
	import starling.animation.Juggler;

	public class StarlingJugglerMechanism extends AbstractGOSystemMechanism implements IAnimatable
	{
		private var juggler:Juggler;

		public function StarlingJugglerMechanism(juggler:Juggler, constantPassedTime:Number = NaN)
		{
			super(constantPassedTime);

			this.juggler = juggler;

			this.juggler.add(this);
		}

		override public function dispose():void
		{
			if (juggler)
			{
				juggler.remove(this);
				juggler = null;
			}

			super.dispose();
		}

		public function advanceTime(time:Number):void
		{
			if (time > 0)
			{
				interact(time);
			}
		}
	}
}
