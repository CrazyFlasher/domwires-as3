/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.devkit.goSystem.mechanisms
{
	import org.flexunit.asserts.assertTrue;

	import starling.animation.Juggler;

	public class StarlingJugglerMechanismTest
	{
		private var m:IStarlingJugglerMechanism;

		[Before]
		public function setUp():void
		{
			m = new StarlingJugglerMechanism();
		}

		[After]
		public function tearDown():void
		{
			m.dispose();
		}

		[Test]
		public function testDispose():void
		{
			m.dispose();
			assertTrue(m.isDisposed);
		}

		[Test]
		public function testSetJuggler():void
		{
			var juggler:Juggler = new Juggler();
			m.setJuggler(juggler);
			assertTrue(juggler.contains(m));
		}

		[Test]
		public function testAdvanceTime():void
		{

		}
	}
}
