/**
 * Created by Anton Nefjodov on 13.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import flexunit.framework.Assert;

	import starling.animation.Juggler;

	public class GameObjectTest
	{

		private var go:IGameObject;

		[Before]
		public function setUp():void
		{
			go = new GameObject(new Juggler());
		}

		[After]
		public function tearDown():void
		{
			go.disposeWithAllChildren();
		}

		[Test]
		public function testRemoveComponent():void
		{
			Assert.assertEquals(go.numComponents, 0);
			Assert.assertEquals(go.numModels, 0);

			go.addComponent(new GameComponent());
			Assert.assertEquals(go.numComponents, 1);
			Assert.assertEquals(go.numModels, 1);
		}

		[Test]
		public function testIsEnabled():void
		{
			Assert.assertTrue(go.isEnabled);
		}

		[Test]
		public function testSetEnabled():void
		{
			go.setEnabled(false);
			Assert.assertFalse(go.isEnabled);
		}

		[Test]
		public function testGetComponentsByType():void
		{
			var c:IGameComponent = new TestComponent();
			var c2:IGameComponent = new TestComponent();
			go.addComponent(c).addComponent(c2);

			Assert.assertEquals(go.getComponentsByType(TestComponent).length, 2);
		}

		[Test]
		public function testDispose():void
		{
			var c:IGameComponent = new TestComponent();
			var c2:IGameComponent = new TestComponent();
			var c3:IGameComponent = new GameComponent();
			go.addComponent(c).addComponent(c2).addComponent(c3);
			go.dispose();

			Assert.assertTrue(go.isDisposed);
			Assert.assertEquals(go.numComponents, 0);
			Assert.assertEquals(go.numModels, 0);
			Assert.assertFalse(c.isDisposed);
			Assert.assertFalse(c2.isDisposed);
			Assert.assertFalse(c3.isDisposed);
		}

		[Test]
		public function testDisposeWithAllChildren():void
		{
			var c:IGameComponent = new TestComponent();
			var c2:IGameComponent = new TestComponent();
			var c3:IGameComponent = new GameComponent();
			go.addComponent(c).addComponent(c2).addComponent(c3);
			go.disposeWithAllChildren();

			Assert.assertTrue(go.isDisposed);
			Assert.assertEquals(go.numComponents, 0);
			Assert.assertEquals(go.numModels, 0);
			Assert.assertTrue(c.isDisposed);
			Assert.assertTrue(c2.isDisposed);
			Assert.assertTrue(c3.isDisposed);
		}

		[Test]
		public function testAdvanceTime():void
		{

		}

		[Test]
		public function testContainsComponent():void
		{
			var c:IGameComponent = new TestComponent();
			var c2:IGameComponent = new TestComponent();
			var c3:IGameComponent = new GameComponent();
			Assert.assertFalse(go.containsComponent(c));
			go.addComponent(c).addComponent(c2).addComponent(c3);
			Assert.assertTrue(go.containsComponent(c));
			Assert.assertTrue(go.containsComponent(c2));
			Assert.assertTrue(go.containsComponent(c3));
		}

		[Test]
		public function testNumComponents():void
		{
			Assert.assertEquals(go.numComponents, 0);
			var c:IGameComponent = new TestComponent();
			var c2:IGameComponent = new TestComponent();
			var c3:IGameComponent = new GameComponent();
			go.addComponent(c).addComponent(c2).addComponent(c3);
			Assert.assertEquals(go.numComponents, 3);
		}

		[Test]
		public function testRemoveAllComponents():void
		{
			var c:IGameComponent = new TestComponent();
			var c2:IGameComponent = new TestComponent();
			var c3:IGameComponent = new GameComponent();
			Assert.assertNull(c.gameObject, c2.gameObject, c3.gameObject);

			go.addComponent(c).addComponent(c2).addComponent(c3);
			Assert.assertEquals(go.numComponents, 3);
			Assert.assertEquals(c.parent, go);
			Assert.assertEquals(c.gameObject, go);
			go.removeAllComponents();
			Assert.assertEquals(go.numComponents, 0);
			Assert.assertNull(c.gameObject, c.parent);
		}

		[Test]
		public function testAddComponent():void
		{
			var c:IGameComponent = new TestComponent();
			go.addComponent(c);
			Assert.assertEquals(go.numComponents, 1);
			Assert.assertEquals(c.gameObject, go);
			Assert.assertEquals(c.parent, go);
		}

		[Test]
		public function testComponentList():void
		{
			var c:IGameComponent = new TestComponent();
			var c2:IGameComponent = new TestComponent();
			var c3:IGameComponent = new GameComponent();

			Assert.assertNull(go.componentList);
			go.addComponent(c).addComponent(c2).addComponent(c3);
			Assert.assertNotNull(go.componentList);
		}

		[Test]
		public function testGetComponentByType():void
		{
			var c:IGameComponent = new TestComponent();
			var c2:IGameComponent = new GameComponent();
			var c3:IGameComponent = new GameComponent();
			go.addComponent(c).addComponent(c2).addComponent(c3);

			Assert.assertEquals(go.getComponentByType(TestComponent), c);
		}
	}
}

import com.crazyfm.extension.goSystem.GameComponent;

internal class TestComponent extends GameComponent
{
	public function TestComponent()
	{
		super();
	}
}
