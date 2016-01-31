/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.ISignalEvent;

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
			mc.addModels(new <IModel>[m1, m2, m3]);
			Assert.assertEquals(mc.numModels, 3);
		}

		[Test]
		public function testRemoveModel():void
		{
			mc.addModels(new <IModel>[m1, m2, m3]);
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

			mc.addModels(new <IModel>[m1, m2, m3]);
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
			mc.addModels(new <IModel>[m1, m2, m3]);
			Assert.assertEquals(mc.numModels, 3);
		}

		[Test]
		public function testDispose():void
		{
			mc.addModels(new <IModel>[m1, m2]);
			mc.addModel(m3);

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

			mc.addModels(new <IModel>[m1, m2]);
			mc.addModel(m3);

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
			mc.addModels(new <IModel>[m1, m2]);
			mc.addModel(m3);
			mc.removeModels(new <IModel>[m2, m3]);

			Assert.assertEquals(mc.numModels, 1);
			Assert.assertTrue(mc.containsModel(m1));
			Assert.assertFalse(mc.containsModel(m2));
			Assert.assertFalse(mc.containsModel(m3));
		}

		[Test]
		public function disposeWithAllChildren():void
		{
			mc.addModels(new <IModel>[m1, m2, m3]);
			mc.disposeWithAllChildren();

			Assert.assertTrue(m1.isDisposed);
			Assert.assertTrue(m2.isDisposed);
			Assert.assertTrue(m3.isDisposed);
		}
	}
}
