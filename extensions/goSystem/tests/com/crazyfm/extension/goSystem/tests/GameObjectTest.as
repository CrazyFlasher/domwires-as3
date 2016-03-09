/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem.tests
{
	import com.crazyfm.extension.goSystem.Component;
	import com.crazyfm.extension.goSystem.GameObject;
	import com.crazyfm.extension.goSystem.IComponent;
	import com.crazyfm.extension.goSystem.IGameObject;

	import flexunit.framework.Assert;

	public class GameObjectTest
	{

		private var go:IGameObject;

		[Before]
		public function setUp():void
		{
			go = new GameObject();
		}

		[After]
		public function tearDown():void
		{
			go.dispose();
		}

		[Test]
		public function testAddComponent():void
		{
			var c:IComponent = new Component();
			go.addComponent(c);
			Assert.assertEquals(go.numComponents, 1);
		}

		[Test]
		public function testDispose():void
		{
			var c:IComponent = new Component();
			go.addComponent(c);

			go.dispose();
			Assert.assertTrue(go.isDisposed);
			Assert.assertEquals(go.numComponents, 0);
		}

		[Test]
		public function testRemoveComponent():void
		{
			var c:IComponent = new Component();
			go.addComponent(c);
			Assert.assertEquals(go.numComponents, 1);

			go.removeComponent(c);
			Assert.assertEquals(go.numComponents, 0);
		}

		[Test]
		public function testAddComponents():void
		{
			go.addComponents(new Component(), new Component(), new Component());
			Assert.assertEquals(go.numComponents, 3);
		}

		[Test]
		public function testRemoveAllComponents():void
		{
			var c:IComponent = new Component();
			go.addComponent(c);
			Assert.assertNotNull(c.parent);
			go.addComponents(new Component(), new Component(), new Component());
			Assert.assertEquals(go.numComponents, 4);
			go.removeAllComponents();
			Assert.assertNull(c.parent);
			Assert.assertEquals(go.numComponents, 0);
		}

		[Test]
		public function testRemoveComponents():void
		{
			var c:IComponent = new Component();
			var c2:IComponent = new Component();
			go.addComponent(c);
			go.addComponent(c2);
			Assert.assertEquals(go.numComponents, 2);
			go.removeComponents(c, c2);
			Assert.assertEquals(go.numComponents, 0);
		}
	}
}
