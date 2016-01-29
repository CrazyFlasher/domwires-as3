/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.ISignalEvent;

	import flexunit.framework.Assert;

	public class ModelTest
	{
		private var model:IModel;

		[Before]
		public function setUp():void
		{
			model = new Model();
		}

		[After]
		public function tearDown():void
		{
			model.dispose();
		}

		[Test]
		public function testDispatchSignal():void
		{
			var gotSignal:Boolean;
			var gotSignalType:String;
			var gotSignalTarget:IModel;
			var gotSignalData:Object = {};

			model.addSignalListener("testSignal", function(event:ISignalEvent):void{
				gotSignal = true;
				gotSignalType = event.type;
				gotSignalTarget = model;
				gotSignalData.prop = event.data.prop;
			});

			model.dispatchSignal("testSignal", {prop:"prop1"});

			Assert.assertTrue(gotSignal);
			Assert.assertEquals(gotSignalType, "testSignal");
			Assert.assertEquals(gotSignalTarget, model);
			Assert.assertEquals(gotSignalData.prop, "prop1");
		}

		[Test]
		public function testAddSignalListener():void
		{
			Assert.assertFalse(model.hasSignalListener("testSignal"));
			model.addSignalListener("testSignal", function(event:ISignalEvent):void{});
			Assert.assertTrue(model.hasSignalListener("testSignal"));
		}

		[Test]
		public function testParent():void
		{
			Assert.assertNull(model.parent);

			var mc:ModelContainer = new ModelContainer();
			mc.addModel(model);
			Assert.assertNotNull(model.parent);

			mc.removeModel(model);
			Assert.assertNull(model.parent);

			mc.dispose();
		}

		[Test]
		public function testRemoveAllSignals():void
		{
			var listener:Function = function(event:ISignalEvent):void{};
			model.addSignalListener("testSignal", listener);
			model.addSignalListener("testSignal2", listener);
			Assert.assertTrue(model.hasSignalListener("testSignal"));
			Assert.assertTrue(model.hasSignalListener("testSignal2"));

			model.removeAllSignals();
			Assert.assertFalse(model.hasSignalListener("testSignal"));
			Assert.assertFalse(model.hasSignalListener("testSignal2"));
		}

		[Test]
		public function testRemoveSignalListener():void
		{
			Assert.assertFalse(model.hasSignalListener("testSignal"));

			var listener:Function = function(event:ISignalEvent):void{};
			model.addSignalListener("testSignal", listener);
			Assert.assertTrue(model.hasSignalListener("testSignal"));
			Assert.assertFalse(model.hasSignalListener("testSignal2"));

			model.addSignalListener("testSignal2", listener);
			model.removeSignalListener("testSignal");
			Assert.assertFalse(model.hasSignalListener("testSignal"));
			Assert.assertTrue(model.hasSignalListener("testSignal2"));

			model.removeSignalListener("testSignal2");
			Assert.assertFalse(model.hasSignalListener("testSignal2"));
		}

		[Test]
		public function testDispose():void
		{
			model.addSignalListener("testSignal", function(event:ISignalEvent):void{});
			model.addSignalListener("testSignal2", function(event:ISignalEvent):void{});
			model.addSignalListener("testSignal3", function(event:ISignalEvent):void{});
			Assert.assertTrue(model.hasSignalListener("testSignal"));
			Assert.assertTrue(model.hasSignalListener("testSignal2"));
			Assert.assertTrue(model.hasSignalListener("testSignal3"));

			var mc:ModelContainer = new ModelContainer();
			mc.addModel(model);
			Assert.assertNotNull(model.parent);

			model.dispose();
			Assert.assertFalse(model.hasSignalListener("testSignal"));
			Assert.assertFalse(model.hasSignalListener("testSignal2"));
			Assert.assertFalse(model.hasSignalListener("testSignal3"));
			Assert.assertNull(model.parent);

			Assert.assertTrue(model.isDisposed);
		}
	}
}
