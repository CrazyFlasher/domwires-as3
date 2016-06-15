/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.devkit.gearSys.mechanisms
{
	import com.crazyfm.extension.gearSys.AbstractGearSysMechanism;

	import starling.animation.IAnimatable;
	import starling.animation.Juggler;

	public class StarlingJugglerMechanism extends AbstractGearSysMechanism implements IAnimatable
	{
		[Autowired]
		public var juggler:Juggler;

		public function StarlingJugglerMechanism(constantPassedTime:Number = NaN)
		{
			super(constantPassedTime);
		}

		[PostConstruct]
		public function init():void
		{
			juggler.add(this);
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
