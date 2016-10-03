/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.mvc.message.IMessage;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;

	public class HierarchyObjectContainerTest
	{

		private var hoc:IHierarchyObjectContainer;

		[Before]
		public function setUp():void
		{
			hoc = new HierarchyObjectContainer();
		}

		[After]
		public function tearDown():void
		{
			if (!hoc.isDisposed)
			{
				hoc.disposeWithAllChildren();
			}
		}

		[Test]
		public function testAddMessageListener():void
		{
			assertFalse(hoc.hasMessageListener(MyCoolEnum.PREVED));

			var eventHandler:Function = function(e:IMessage):void {};

			hoc.addMessageListener(MyCoolEnum.PREVED, eventHandler);

			assertTrue(hoc.hasMessageListener(MyCoolEnum.PREVED));
		}

		[Test]
		public function testAdd():void
		{
			assertEquals(hoc.children.length, 0);

			hoc.add(new AbstractHierarchyObject()).add(new AbstractHierarchyObject());

			assertEquals(hoc.children.length, 2);
		}

		[Test]
		public function testDisposeWithAllChildren():void
		{
			var ho_1:IHierarchyObject = new AbstractHierarchyObject();
			var ho_2:IHierarchyObject = new AbstractHierarchyObject();
			hoc.add(ho_1).add(ho_2);
			hoc.disposeWithAllChildren();

			assertTrue(hoc.isDisposed, ho_1.isDisposed, ho_2.isDisposed);
			assertNull(ho_1.parent, ho_2.parent, hoc.children);
		}

		[Test]
		public function testDispose():void
		{
			var ho_1:IHierarchyObject = new AbstractHierarchyObject();
			var ho_2:IHierarchyObject = new AbstractHierarchyObject();
			hoc.add(ho_1).add(ho_2);
			hoc.dispose();

			assertTrue(hoc.isDisposed);
			assertNull(hoc.children);
			assertFalse(ho_1.isDisposed, ho_2.isDisposed);
		}

		/*[Test]
		public function testDispatchMessageToChildren():void
		{
			var ho_1:IHierarchyObject = new AbstractHierarchyObject();
			var ho_2:IHierarchyObject = new AbstractHierarchyObject();
			hoc.add(ho_1).add(ho_2);

			var count:int;
			var eventHandler:Function = function(e:IMessageEvent):void {
				count++;
			};

			ho_1.addMessageListener(MyCoolEnum.PREVED, eventHandler);
			ho_2.addMessageListener(MyCoolEnum.PREVED, eventHandler);

			hoc.dispatchMessageToChildren(MyCoolEnum.PREVED);

			assertEquals(count, 2);
		}*/

		[Test]
		public function testRemove():void
		{
			var ho_1:IHierarchyObject = new AbstractHierarchyObject();
			var ho_2:IHierarchyObject = new AbstractHierarchyObject();
			hoc.add(ho_1).add(ho_2);

			assertEquals(ho_1.parent, hoc);
			hoc.remove(ho_1);
			assertNull(ho_1.parent);
			assertEquals(hoc.children.length, 1);
		}

		[Test]
		public function testRemoveMessageListener():void
		{
			var eventHandler:Function = function(e:IMessage):void {};

			hoc.addMessageListener(MyCoolEnum.PREVED, eventHandler);
			hoc.removeMessageListener(MyCoolEnum.PREVED, eventHandler);

			assertFalse(hoc.hasMessageListener(MyCoolEnum.PREVED));
		}

		[Test]
		public function testRemoveAll():void
		{
			hoc.add(new AbstractHierarchyObject()).add(new AbstractHierarchyObject());
			hoc.removeAll();
			assertEquals(hoc.children.length, 0);
		}

		[Test]
		public function testRemoveAllMessageListeners():void
		{
			var eventHandler:Function = function(e:IMessage):void {};

			hoc.addMessageListener(MyCoolEnum.PREVED, eventHandler);
			hoc.addMessageListener(MyCoolEnum.BOGA, eventHandler);
			hoc.addMessageListener(MyCoolEnum.SHALOM, eventHandler);

			assertTrue(
					hoc.hasMessageListener(MyCoolEnum.PREVED),
					hoc.hasMessageListener(MyCoolEnum.BOGA),
					hoc.hasMessageListener(MyCoolEnum.SHALOM)
			);

			hoc.removeAllMessageListeners();

			assertFalse(
					hoc.hasMessageListener(MyCoolEnum.PREVED),
					hoc.hasMessageListener(MyCoolEnum.BOGA),
					hoc.hasMessageListener(MyCoolEnum.SHALOM)
			);
		}

		[Test]
		public function testChangeParent():void
		{
			var ho_1:IHierarchyObject = new AbstractHierarchyObject();
			hoc.add(ho_1);

			assertEquals(ho_1.parent, hoc);
			assertEquals(hoc.children.length, 1);

			var hoc_2:IHierarchyObjectContainer = new HierarchyObjectContainer();
			hoc_2.add(ho_1);

			assertEquals(ho_1.parent, hoc_2);
			assertEquals(hoc.children.length, 0);
		}

		[Test]
		public function testAddAt():void
		{
			var ho_1:IHierarchyObject = new AbstractHierarchyObject();
			var ho_2:IHierarchyObject = new AbstractHierarchyObject();
			var ho_3:IHierarchyObject = new AbstractHierarchyObject();

			hoc.add(ho_1);
			hoc.add(ho_2);
			hoc.add(ho_3);

			assertEquals(hoc.children.indexOf(ho_1), 0);
			assertEquals(hoc.children.indexOf(ho_2), 1);
			assertEquals(hoc.children.indexOf(ho_3), 2);

			assertEquals(ho_1.parent, hoc);
			assertEquals(ho_2.parent, hoc);
			assertEquals(ho_3.parent, hoc);

			hoc.add(ho_3, 0);

			assertEquals(hoc.children.indexOf(ho_3), 0);

			assertEquals(ho_3.parent, hoc);
		}

		[Test]
		public function testAddAtParent():void
		{
			var ho_1:IHierarchyObject = new AbstractHierarchyObject();
			hoc.add(ho_1, 0);
			assertTrue(ho_1.parent, hoc);
		}

		[Test(expects="Error")]
		public function testAddAtError():void
		{
			hoc.add(new AbstractHierarchyObject(), 5);
		}
	}
}
