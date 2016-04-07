/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazyfm.core.mvc.model
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.event.ISignalEvent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;

	public class ModelContainerTest
	{
		private var mc:ModelContainer;

		private var m1:Model;
		private var m2:Model;
		private var m3:Model;

		[Before]
		public function setUp():void
		{
			mc = new ModelContainer();
			m1 = new Model();
			m2 = new Model();
			m3 = new Model();
		}

		[After]
		public function tearDown():void
		{
			mc.dispose();
			m1.dispose();
			m2.dispose();
			m3.dispose();
		}

		[Test]
		public function testNumModels():void
		{
			mc.addModel(m1).addModel(m2).addModel(m3);
			assertEquals(mc.numModels, 3);
		}

		[Test]
		public function testRemoveModel():void
		{
			mc.addModel(m1).addModel(m2).addModel(m3);
			mc.removeModel(m1);
			assertEquals(mc.numModels, 2);
			assertNull(m1.parent);
		}

		[Test]
		public function testContainsModel():void
		{
			assertFalse(mc.containsModel(m1));
			assertFalse(mc.containsModel(m2));
			assertFalse(mc.containsModel(m3));

			mc.addModel(m1).addModel(m2).addModel(m3);
			assertTrue(mc.containsModel(m1));
			assertTrue(mc.containsModel(m2));
			assertTrue(mc.containsModel(m3));

			mc.removeModel(m1);
			assertFalse(mc.containsModel(m1));
			assertTrue(mc.containsModel(m2));
			assertTrue(mc.containsModel(m3));
		}

		[Test]
		public function testAddModel():void
		{
			assertEquals(mc.numModels, 0);
			mc.addModel(m1);
			assertEquals(mc.numModels, 1);
			mc.addModel(m1);
			mc.addModel(m1);
			mc.addModel(m1);
			assertEquals(mc.numModels, 1);
		}

		[Test]
		public function testAddModels():void
		{
			assertEquals(mc.numModels, 0);
			mc.addModel(m1).addModel(m2).addModel(m3);
			assertEquals(mc.numModels, 3);
		}

		[Test]
		public function testDispose():void
		{
			mc.addModel(m1).addModel(m2).addModel(m3);

			var listener:Function = function(event:ISignalEvent):void {};
			mc.addSignalListener(MyCoolEnum.PREVED, listener);
			assertTrue(mc.hasSignalListener(MyCoolEnum.PREVED));

			mc.dispose();
			assertEquals(mc.numModels, 0);
			assertFalse(mc.hasSignalListener(MyCoolEnum.PREVED));
			assertTrue(mc.isDisposed);

			assertFalse(m1.isDisposed);
			assertFalse(m2.isDisposed);
			assertFalse(m3.isDisposed);
		}

		[Test]
		public function testRemoveAllModels():void
		{
			assertEquals(mc.numModels, 0);

			mc.addModel(m1).addModel(m2).addModel(m3);

			assertNotNull(m1.parent);
			assertNotNull(m2.parent);
			assertNotNull(m3.parent);
			assertEquals(mc.numModels, 3);

			mc.removeAllModels();

			assertEquals(mc.numModels, 0);
			assertFalse(mc.containsModel(m1));
			assertFalse(mc.containsModel(m2));
			assertFalse(mc.containsModel(m3));

			assertNull(m1.parent);
			assertNull(m2.parent);
			assertNull(m3.parent);
		}

		[Test]
		public function testOnEventBubbled():void
		{
			var bubbledType:Enum;
			var bubbledData:Object;

			mc.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{
				bubbledType = event.type;
				bubbledData = event.data;
			});

			m1.dispatchSignal(MyCoolEnum.PREVED, {name:"Anton"});
			assertNull(bubbledType);
			assertNull(bubbledData);

			mc.addModel(m1);
			m1.dispatchSignal(MyCoolEnum.PREVED, {name:"Anton"});
			assertEquals(bubbledType, MyCoolEnum.PREVED);
			assertEquals(bubbledData.name, "Anton");

			bubbledType = null;
			bubbledData = null;

			mc.removeModel(m1);
			m1.dispatchSignal(MyCoolEnum.PREVED, {name:"Anton"});
			assertNull(bubbledType);
			assertNull(bubbledData);
		}

		[Test]
		public function testRemoveModels():void
		{
			mc.addModel(m1).addModel(m2).addModel(m3);
			mc.removeModel(m2).removeModel(m3);

			assertEquals(mc.numModels, 1);
			assertTrue(mc.containsModel(m1));
			assertFalse(mc.containsModel(m2));
			assertFalse(mc.containsModel(m3));
		}

		[Test]
		public function disposeWithAllChildren():void
		{
			var mc2:IModelContainer = new ModelContainer();

			mc.addModel(m1)
			  .addModel(m2)
			  .addModel(mc2
			  	.addModel(m3));

			assertTrue(m3.parent, mc2);

			mc.disposeWithAllChildren();

			assertTrue(m1.isDisposed);
			assertTrue(m2.isDisposed);
			assertTrue(m3.isDisposed);
			assertNull(m3.parent);
			assertTrue(mc2.isDisposed);
			assertEquals(mc2.numModels, 0);
		}

		[Test]
		public function testAddedToNewParent():void
		{
			var mc2:IModelContainer = new ModelContainer();
			assertNull(m1.parent);

			mc.addModel(m1);
			assertEquals(m1.parent, mc);

			mc2.addModel(m1);
			assertEquals(m1.parent, mc2);

			assertEquals(mc.numModels, 0);

			mc2.disposeWithAllChildren();
		}

		[Test]
		public function testDispatchSignalToChildren_2_LevelHierarchy():void
		{
			/**
			 * 		 mc
			 * 	  /  |  \
			 * 	 m1  m2  m3
			 */

			mc.addModel(m1).addModel(m2).addModel(m3);

			var receivedSignalCount:int;
			var listener:Function = function(event:ISignalEvent):void{
				receivedSignalCount++;
			};

			mc.dispatchSignalToChildren(MyCoolEnum.PREVED);
			assertEquals(receivedSignalCount, 0);

			receivedSignalCount = 0;

			m1.addSignalListener(MyCoolEnum.PREVED, listener);
			mc.dispatchSignalToChildren(MyCoolEnum.PREVED);
			assertEquals(receivedSignalCount, 1);

			receivedSignalCount = 0;

			m2.addSignalListener(MyCoolEnum.PREVED, listener);
			m3.addSignalListener(MyCoolEnum.PREVED, listener);

			mc.dispatchSignalToChildren(MyCoolEnum.PREVED);
			assertEquals(receivedSignalCount, 3);
		}

		[Test]
		public function testDispatchSignalToChildren_3_LevelHierarchy():void
		{
			/**
			 * 			mc
			 * 		  /	  \
			 * 		 mc2   m1
			 * 	   /  |
			 * 	 m2	  m3
			 */

			var mc2:IModelContainer = new ModelContainer();
			mc.addModel(m1);
			mc.addModel(mc2);
			mc.addModel(m2).addModel(m3);

			var mc2_received:Boolean;
			var m1_received:Boolean;
			var m2_received:Boolean;
			var m3_received:Boolean;

			mc2.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{
				mc2_received = true;
			});

			m1.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{
				m1_received = true;
			});

			m2.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{
				m2_received = true;
			});

			m2.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{
				m3_received = true;
			});

			mc.dispatchSignalToChildren(MyCoolEnum.PREVED);
			assertTrue(mc2_received, m1_received, m2_received, m3_received);

			mc2_received = m1_received = m2_received = m3_received = false;

			mc2.removeAllSignalListeners();
			mc.dispatchSignalToChildren(MyCoolEnum.PREVED);
			assertTrue(m1_received, m2_received, m3_received);
			assertFalse(mc2_received);
		}
	}
}
