/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class HierarchyObjectTest
	{
		private var ho:IHierarchyObject;

		[Before]
		public function setUp():void
		{
			ho = new AbstractHierarchyObject();
		}

		[After]
		public function tearDown():void
		{
			ho.dispose();
		}

		[Test]
		public function testDispose():void
		{
			addToContainer();

			ho.dispose();

			assertTrue(ho.isDisposed);
			assertNull(ho.parent);
		}

		[Test]
		public function testParent():void
		{
			assertNull(ho.parent);

			var hoc:IHierarchyObjectContainer = addToContainer();

			assertEquals(ho.parent, hoc);
		}

		private function addToContainer():IHierarchyObjectContainer
		{
			var hoc:IHierarchyObjectContainer = new HierarchyObjectContainer();
			hoc.add(ho);

			return hoc;
		}
	}
}
