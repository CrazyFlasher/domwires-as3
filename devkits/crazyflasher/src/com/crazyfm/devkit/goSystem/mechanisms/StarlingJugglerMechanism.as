/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.devkit.goSystem.mechanisms
{
	import com.crazyfm.extension.goSystem.mechanisms.AbstractMechanism;

	import starling.animation.Juggler;

	public class StarlingJugglerMechanism extends AbstractMechanism implements IStarlingJugglerMechanism
	{
		private var juggler:Juggler;

		public function StarlingJugglerMechanism()
		{

		}

		public function setJuggler(juggler:Juggler):IStarlingJugglerMechanism
		{
			if (this.juggler)
			{
				this.juggler.remove(this);
			}

			this.juggler = juggler;

			this.juggler.add(this);

			return this;
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
			interact(time);
		}
	}
}
