/**
 * Created by Anton Nefjodov on 13.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class GearSysObjectTest
	{

		private var go:IGearSysObject;

		[Before]
		public function setUp():void
		{
			go = new GearSysObject();
		}

		[After]
		public function tearDown():void
		{
			go.disposeWithAllChildren();
		}

		[Test]
		public function testRemoveComponent():void
		{
			assertEquals(go.numComponents, 0);

			go.addComponent(new GearSysComponent());
			assertEquals(go.numComponents, 1);
		}

		[Test]
		public function testIsEnabled():void
		{
			assertTrue(go.isEnabled);
		}

		[Test]
		public function testSetEnabled():void
		{
			go.setEnabled(false);
			assertFalse(go.isEnabled);
		}

		[Test]
		public function testGetComponentsByType():void
		{
			var c:IGearSysComponent = new TestComponent();
			var c2:IGearSysComponent = new TestComponent();
			go.addComponent(c).addComponent(c2);

			assertEquals(go.getComponentsByType(TestComponent).length, 2);
		}

		[Test]
		public function testDispose():void
		{
			var c:IGearSysComponent = new TestComponent();
			var c2:IGearSysComponent = new TestComponent();
			var c3:IGearSysComponent = new GearSysComponent();
			go.addComponent(c).addComponent(c2).addComponent(c3);
			go.dispose();

			assertTrue(go.isDisposed);
			assertEquals(go.numComponents, 0);
			assertFalse(c.isDisposed);
			assertFalse(c2.isDisposed);
			assertFalse(c3.isDisposed);
		}

		[Test]
		public function testDisposeWithAllChildren():void
		{
			var c:IGearSysComponent = new TestComponent();
			var c2:IGearSysComponent = new TestComponent();
			var c3:IGearSysComponent = new GearSysComponent();
			go.addComponent(c).addComponent(c2).addComponent(c3);
			go.disposeWithAllChildren();

			assertTrue(go.isDisposed);
			assertEquals(go.numComponents, 0);
			assertTrue(c.isDisposed);
			assertTrue(c2.isDisposed);
			assertTrue(c3.isDisposed);
			assertNull(c.parent, c.gameObject);
		}

		[Test]
		public function testAdvanceTime():void
		{

		}

		[Test]
		public function testContainsComponent():void
		{
			var c:IGearSysComponent = new TestComponent();
			var c2:IGearSysComponent = new TestComponent();
			var c3:IGearSysComponent = new GearSysComponent();
			assertFalse(go.containsComponent(c));
			go.addComponent(c).addComponent(c2).addComponent(c3);
			assertTrue(go.containsComponent(c));
			assertTrue(go.containsComponent(c2));
			assertTrue(go.containsComponent(c3));
		}

		[Test]
		public function testNumComponents():void
		{
			assertEquals(go.numComponents, 0);
			var c:IGearSysComponent = new TestComponent();
			var c2:IGearSysComponent = new TestComponent();
			var c3:IGearSysComponent = new GearSysComponent();
			go.addComponent(c).addComponent(c2).addComponent(c3);
			assertEquals(go.numComponents, 3);
		}

		[Test]
		public function testRemoveAllComponents():void
		{
			var c:IGearSysComponent = new TestComponent();
			var c2:IGearSysComponent = new TestComponent();
			var c3:IGearSysComponent = new GearSysComponent();
			assertNull(c.gameObject, c2.gameObject, c3.gameObject);

			go.addComponent(c).addComponent(c2).addComponent(c3);
			assertEquals(go.numComponents, 3);
			assertEquals(c.parent, go);
			assertEquals(c.gameObject, go);
			go.removeAllComponents();
			assertEquals(go.numComponents, 0);
			assertNull(c.gameObject, c.parent);
		}

		[Test]
		public function testAddComponent():void
		{
			var c:IGearSysComponent = new TestComponent();
			go.addComponent(c);
			assertEquals(go.numComponents, 1);
			assertEquals(c.gameObject, go);
			assertEquals(c.parent, go);
		}

		[Test]
		public function testComponentList():void
		{
			var c:IGearSysComponent = new TestComponent();
			var c2:IGearSysComponent = new TestComponent();
			var c3:IGearSysComponent = new GearSysComponent();

			assertEquals(go.componentList.length, 0);
			go.addComponent(c).addComponent(c2).addComponent(c3);
			assertNotNull(go.componentList);
		}

		[Test]
		public function testGetComponentByType():void
		{
			var c:IGearSysComponent = new TestComponent();
			var c2:IGearSysComponent = new GearSysComponent();
			var c3:IGearSysComponent = new GearSysComponent();
			go.addComponent(c).addComponent(c2).addComponent(c3);

			assertEquals(go.getComponentByType(TestComponent), c);
		}

		[Test]
		public function testGetGoSystem():void
		{
			assertNull(go.parent);
			var sys:IGearSys = new GearSys();
			sys.addGameObject(go);
			assertEquals(go.parent, sys);
			sys.removeGameObject(go);
			assertNull(go.parent);
		}
	}
}

import com.crazyfm.extension.gearSys.GearSysComponent;

internal class TestComponent extends GearSysComponent
{
	public function TestComponent()
	{
		super();
	}
}
