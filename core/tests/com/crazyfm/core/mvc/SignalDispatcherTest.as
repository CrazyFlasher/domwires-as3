/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc
{
	import com.crazyfm.core.mvc.event.ISignalDispatcher;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.event.SignalDispatcher;

	import flexunit.framework.Assert;

	public class SignalDispatcherTest
	{

		private var d:SignalDispatcher;

		[Before]
		public function setUp():void
		{
			d = new SignalDispatcher();
		}

		[After]
		public function tearDown():void
		{
			d.dispose();
		}

		[Test]
		public function testDispatchSignal():void
		{
			var gotSignal:Boolean;
			var gotSignalType:String;
			var gotSignalTarget:ISignalDispatcher;
			var gotSignalData:Object = {};

			d.addSignalListener("testSignal", function(event:ISignalEvent):void{
				gotSignal = true;
				gotSignalType = event.type;
				gotSignalTarget = event.target as ISignalDispatcher;
				gotSignalData.prop = event.data.prop;
			});

			d.dispatchSignal("testSignal", {prop:"prop1"});

			Assert.assertTrue(gotSignal);
			Assert.assertEquals(gotSignalType, "testSignal");
			Assert.assertEquals(gotSignalTarget, d);
			Assert.assertEquals(gotSignalData.prop, "prop1");
		}

		[Test]
		public function testAddSignalListener():void
		{
			Assert.assertFalse(d.hasSignalListener("testSignal"));
			d.addSignalListener("testSignal", function(event:ISignalEvent):void{});
			Assert.assertTrue(d.hasSignalListener("testSignal"));
		}

		[Test]
		public function testRemoveAllSignals():void
		{
			var listener:Function = function(event:ISignalEvent):void{};
			d.addSignalListener("testSignal", listener);
			d.addSignalListener("testSignal2", listener);
			Assert.assertTrue(d.hasSignalListener("testSignal"));
			Assert.assertTrue(d.hasSignalListener("testSignal2"));

			d.removeAllSignalListeners();
			Assert.assertFalse(d.hasSignalListener("testSignal"));
			Assert.assertFalse(d.hasSignalListener("testSignal2"));
		}

		[Test]
		public function testRemoveSignalListener():void
		{
			Assert.assertFalse(d.hasSignalListener("testSignal"));

			var listener:Function = function(event:ISignalEvent):void{};
			d.addSignalListener("testSignal", listener);
			Assert.assertTrue(d.hasSignalListener("testSignal"));
			Assert.assertFalse(d.hasSignalListener("testSignal2"));

			d.addSignalListener("testSignal2", listener);
			d.removeSignalListener("testSignal");
			Assert.assertFalse(d.hasSignalListener("testSignal"));
			Assert.assertTrue(d.hasSignalListener("testSignal2"));

			d.removeSignalListener("testSignal2");
			Assert.assertFalse(d.hasSignalListener("testSignal2"));
		}

		[Test]
		public function testDispose():void
		{
			d.addSignalListener("testSignal", function(event:ISignalEvent):void{});
			d.addSignalListener("testSignal2", function(event:ISignalEvent):void{});
			d.addSignalListener("testSignal3", function(event:ISignalEvent):void{});
			d.dispose();

			Assert.assertFalse(d.hasSignalListener("testSignal"));
			Assert.assertFalse(d.hasSignalListener("testSignal2"));
			Assert.assertFalse(d.hasSignalListener("testSignal3"));

			Assert.assertTrue(d.isDisposed);
		}

		[Test]
		public function testHasSignalListener():void
		{

		}
	}
}
