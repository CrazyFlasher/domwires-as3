/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import flexunit.framework.Assert;

	public class GameComponentTest
	{
		private var c:IGameComponent;

		[Before]
		public function setUp():void
		{
			c = new GameComponent();
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
			var go:IGameObject = new GameObject();
			go.addComponent(c);
			Assert.assertEquals(c.parent, go);
			go.removeComponent(c);
			Assert.assertNull(c.parent);
		}
	}
}
