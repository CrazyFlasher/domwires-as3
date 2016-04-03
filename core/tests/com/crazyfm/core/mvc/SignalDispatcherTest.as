/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.event.ISignalDispatcher;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.event.SignalDispatcher;

	import flexunit.framework.Assert;

	import testObject.MyCoolEnum;

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
			var gotSignalType:Enum;
			var gotSignalTarget:ISignalDispatcher;
			var gotSignalData:Object = {};

			d.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{
				gotSignal = true;
				gotSignalType = event.type;
				gotSignalTarget = event.target as ISignalDispatcher;
				gotSignalData.prop = event.data.prop;
			});

			d.dispatchSignal(MyCoolEnum.PREVED, {prop:"prop1"});

			Assert.assertTrue(gotSignal);
			Assert.assertEquals(gotSignalType, MyCoolEnum.PREVED);
			Assert.assertEquals(gotSignalTarget, d);
			Assert.assertEquals(gotSignalData.prop, "prop1");
		}

		[Test]
		public function testAddSignalListener():void
		{
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));
			d.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{});
			Assert.assertTrue(d.hasSignalListener(MyCoolEnum.PREVED));
		}

		[Test]
		public function testRemoveAllSignals():void
		{
			var listener:Function = function(event:ISignalEvent):void{};
			d.addSignalListener(MyCoolEnum.PREVED, listener);
			d.addSignalListener(MyCoolEnum.BOGA, listener);
			Assert.assertTrue(d.hasSignalListener(MyCoolEnum.PREVED));
			Assert.assertTrue(d.hasSignalListener(MyCoolEnum.BOGA));

			d.removeAllSignalListeners();
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.BOGA));
		}

		[Test]
		public function testRemoveSignalListener():void
		{
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));

			var listener:Function = function(event:ISignalEvent):void{};
			d.addSignalListener(MyCoolEnum.PREVED, listener);
			Assert.assertTrue(d.hasSignalListener(MyCoolEnum.PREVED));
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.BOGA));

			d.addSignalListener(MyCoolEnum.BOGA, listener);
			d.removeSignalListener(MyCoolEnum.PREVED);
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));
			Assert.assertTrue(d.hasSignalListener(MyCoolEnum.BOGA));

			d.removeSignalListener(MyCoolEnum.BOGA);
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.BOGA));
		}

		[Test]
		public function testDispose():void
		{
			d.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{});
			d.addSignalListener(MyCoolEnum.BOGA, function(event:ISignalEvent):void{});
			d.addSignalListener(MyCoolEnum.SHALOM, function(event:ISignalEvent):void{});
			d.dispose();

			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.BOGA));
			Assert.assertFalse(d.hasSignalListener(MyCoolEnum.SHALOM));

			Assert.assertTrue(d.isDisposed);
		}

		[Test]
		public function testHasSignalListener():void
		{

		}
	}
}
