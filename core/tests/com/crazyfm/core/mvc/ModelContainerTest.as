/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazyfm.core.mvc
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.IModelContainer;
	import com.crazyfm.core.mvc.model.Model;
	import com.crazyfm.core.mvc.model.ModelContainer;

	import flexunit.framework.Assert;

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
			Assert.assertEquals(mc.numModels, 3);
		}

		[Test]
		public function testRemoveModel():void
		{
			mc.addModel(m1).addModel(m2).addModel(m3);
			mc.removeModel(m1);
			Assert.assertEquals(mc.numModels, 2);
			Assert.assertNull(m1.parent);
		}

		[Test]
		public function testContainsModel():void
		{
			Assert.assertFalse(mc.containsModel(m1));
			Assert.assertFalse(mc.containsModel(m2));
			Assert.assertFalse(mc.containsModel(m3));

			mc.addModel(m1).addModel(m2).addModel(m3);
			Assert.assertTrue(mc.containsModel(m1));
			Assert.assertTrue(mc.containsModel(m2));
			Assert.assertTrue(mc.containsModel(m3));

			mc.removeModel(m1);
			Assert.assertFalse(mc.containsModel(m1));
			Assert.assertTrue(mc.containsModel(m2));
			Assert.assertTrue(mc.containsModel(m3));
		}

		[Test]
		public function testAddModel():void
		{
			Assert.assertEquals(mc.numModels, 0);
			mc.addModel(m1);
			Assert.assertEquals(mc.numModels, 1);
			mc.addModel(m1);
			mc.addModel(m1);
			mc.addModel(m1);
			Assert.assertEquals(mc.numModels, 1);
		}

		[Test]
		public function testAddModels():void
		{
			Assert.assertEquals(mc.numModels, 0);
			mc.addModel(m1).addModel(m2).addModel(m3);
			Assert.assertEquals(mc.numModels, 3);
		}

		[Test]
		public function testDispose():void
		{
			mc.addModel(m1).addModel(m2).addModel(m3);

			var listener:Function = function(event:ISignalEvent):void {};
			mc.addSignalListener("test", listener);
			Assert.assertTrue(mc.hasSignalListener("test"));

			mc.dispose();
			Assert.assertEquals(mc.numModels, 0);
			Assert.assertFalse(mc.hasSignalListener("test"));
			Assert.assertTrue(mc.isDisposed);

			Assert.assertFalse(m1.isDisposed);
			Assert.assertFalse(m2.isDisposed);
			Assert.assertFalse(m3.isDisposed);
		}

		[Test]
		public function testRemoveAllModels():void
		{
			Assert.assertEquals(mc.numModels, 0);

			mc.addModel(m1).addModel(m2).addModel(m3);

			Assert.assertNotNull(m1.parent);
			Assert.assertNotNull(m2.parent);
			Assert.assertNotNull(m3.parent);
			Assert.assertEquals(mc.numModels, 3);

			mc.removeAllModels();

			Assert.assertEquals(mc.numModels, 0);
			Assert.assertFalse(mc.containsModel(m1));
			Assert.assertFalse(mc.containsModel(m2));
			Assert.assertFalse(mc.containsModel(m3));

			Assert.assertNull(m1.parent);
			Assert.assertNull(m2.parent);
			Assert.assertNull(m3.parent);
		}

		[Test]
		public function testOnEventBubbled():void
		{
			var bubbledType:String;
			var bubbledData:Object;

			mc.addSignalListener("test", function(event:ISignalEvent):void{
				bubbledType = event.type;
				bubbledData = event.data;
			});

			m1.dispatchSignal("test", {name:"Anton"});
			Assert.assertNull(bubbledType);
			Assert.assertNull(bubbledData);

			mc.addModel(m1);
			m1.dispatchSignal("test", {name:"Anton"});
			Assert.assertEquals(bubbledType, "test");
			Assert.assertEquals(bubbledData.name, "Anton");

			bubbledType = null;
			bubbledData = null;

			mc.removeModel(m1);
			m1.dispatchSignal("test", {name:"Anton"});
			Assert.assertNull(bubbledType);
			Assert.assertNull(bubbledData);
		}

		[Test]
		public function testRemoveModels():void
		{
			mc.addModel(m1).addModel(m2).addModel(m3);
			mc.removeModel(m2).removeModel(m3);

			Assert.assertEquals(mc.numModels, 1);
			Assert.assertTrue(mc.containsModel(m1));
			Assert.assertFalse(mc.containsModel(m2));
			Assert.assertFalse(mc.containsModel(m3));
		}

		[Test]
		public function disposeWithAllChildren():void
		{
			var mc2:IModelContainer = new ModelContainer();

			mc.addModel(m1)
			  .addModel(m2)
			  .addModel(mc2
			  	.addModel(m3));

			Assert.assertTrue(m3.parent, mc2);

			mc.disposeWithAllChildren();

			Assert.assertTrue(m1.isDisposed);
			Assert.assertTrue(m2.isDisposed);
			Assert.assertTrue(m3.isDisposed);
			Assert.assertNull(m3.parent);
			Assert.assertTrue(mc2.isDisposed);
			Assert.assertEquals(mc2.numModels, 0);
		}

		[Test]
		public function testAddedToNewParent():void
		{
			var mc2:IModelContainer = new ModelContainer();
			Assert.assertNull(m1.parent);

			mc.addModel(m1);
			Assert.assertEquals(m1.parent, mc);

			mc2.addModel(m1);
			Assert.assertEquals(m1.parent, mc2);

			Assert.assertEquals(mc.numModels, 0);

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

			mc.dispatchSignalToChildren("test");
			Assert.assertEquals(receivedSignalCount, 0);

			receivedSignalCount = 0;

			m1.addSignalListener("test", listener);
			mc.dispatchSignalToChildren("test");
			Assert.assertEquals(receivedSignalCount, 1);

			receivedSignalCount = 0;

			m2.addSignalListener("test", listener);
			m3.addSignalListener("test", listener);

			mc.dispatchSignalToChildren("test");
			Assert.assertEquals(receivedSignalCount, 3);
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

			mc2.addSignalListener("test", function(event:ISignalEvent):void{
				mc2_received = true;
			});

			m1.addSignalListener("test", function(event:ISignalEvent):void{
				m1_received = true;
			});

			m2.addSignalListener("test", function(event:ISignalEvent):void{
				m2_received = true;
			});

			m2.addSignalListener("test", function(event:ISignalEvent):void{
				m3_received = true;
			});

			mc.dispatchSignalToChildren("test");
			Assert.assertTrue(mc2_received, m1_received, m2_received, m3_received);

			mc2_received = m1_received = m2_received = m3_received = false;

			mc2.removeAllSignalListeners();
			mc.dispatchSignalToChildren("test");
			Assert.assertTrue(m1_received, m2_received, m3_received);
			Assert.assertFalse(mc2_received);
		}
	}
}
