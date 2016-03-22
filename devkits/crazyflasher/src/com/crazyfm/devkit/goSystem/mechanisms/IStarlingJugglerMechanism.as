/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.devkit.goSystem.mechanisms
{
	import com.crazyfm.extension.goSystem.IMechanism;

	import starling.animation.IAnimatable;
	import starling.animation.Juggler;

	public interface IStarlingJugglerMechanism extends IMechanism, IAnimatable
	{
		function setJuggler(juggler:Juggler):IStarlingJugglerMechanism;
	}
}
