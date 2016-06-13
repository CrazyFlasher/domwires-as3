/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.devkit.gearSys.mechanisms
{
	import org.flexunit.asserts.assertTrue;

	import starling.animation.Juggler;

	public class StarlingJugglerMechanismTest
	{
		private var m:StarlingJugglerMechanism;
		private var juggler:Juggler;
		[Before]
		public function setUp():void
		{
			juggler = new Juggler();
			m = new StarlingJugglerMechanism(juggler);
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
		public function testJuggler():void
		{
			assertTrue(juggler.contains(m));
		}

		[Test]
		public function testAdvanceTime():void
		{

		}
	}
}
