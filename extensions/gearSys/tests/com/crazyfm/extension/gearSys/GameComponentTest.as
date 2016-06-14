/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	import flexunit.framework.Assert;

	public class GameComponentTest
	{
		private var c:IGearSysComponent;

		[Before]
		public function setUp():void
		{
			c = new GearSysComponent();
		}

		[After]
		public function tearDown():void
		{
			c.dispose();
		}

		[Test]
		public function testAdvanceTime():void
		{

		}

		[Test]
		public function testGetGameObject():void
		{
			Assert.assertNull(c.parent);
			var go:IGearSysObject = new GearSysObject();
			go.addComponent(c);
			Assert.assertEquals(c.parent, go);
			go.removeComponent(c);
			Assert.assertNull(c.parent);
		}
	}
}
