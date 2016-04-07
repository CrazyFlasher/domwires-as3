/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc.event
{
	import com.crazyfm.core.common.Enum;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

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

			assertTrue(gotSignal);
			assertEquals(gotSignalType, MyCoolEnum.PREVED);
			assertEquals(gotSignalTarget, d);
			assertEquals(gotSignalData.prop, "prop1");
		}

		[Test]
		public function testAddSignalListener():void
		{
			assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));
			d.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{});
			assertTrue(d.hasSignalListener(MyCoolEnum.PREVED));
		}

		[Test]
		public function testRemoveAllSignals():void
		{
			var listener:Function = function(event:ISignalEvent):void{};
			d.addSignalListener(MyCoolEnum.PREVED, listener);
			d.addSignalListener(MyCoolEnum.BOGA, listener);
			assertTrue(d.hasSignalListener(MyCoolEnum.PREVED));
			assertTrue(d.hasSignalListener(MyCoolEnum.BOGA));

			d.removeAllSignalListeners();
			assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));
			assertFalse(d.hasSignalListener(MyCoolEnum.BOGA));
		}

		[Test]
		public function testRemoveSignalListener():void
		{
			assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));

			var listener:Function = function(event:ISignalEvent):void{};
			d.addSignalListener(MyCoolEnum.PREVED, listener);
			assertTrue(d.hasSignalListener(MyCoolEnum.PREVED));
			assertFalse(d.hasSignalListener(MyCoolEnum.BOGA));

			d.addSignalListener(MyCoolEnum.BOGA, listener);
			d.removeSignalListener(MyCoolEnum.PREVED);
			assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));
			assertTrue(d.hasSignalListener(MyCoolEnum.BOGA));

			d.removeSignalListener(MyCoolEnum.BOGA);
			assertFalse(d.hasSignalListener(MyCoolEnum.BOGA));
		}

		[Test]
		public function testDispose():void
		{
			d.addSignalListener(MyCoolEnum.PREVED, function(event:ISignalEvent):void{});
			d.addSignalListener(MyCoolEnum.BOGA, function(event:ISignalEvent):void{});
			d.addSignalListener(MyCoolEnum.SHALOM, function(event:ISignalEvent):void{});
			d.dispose();

			assertFalse(d.hasSignalListener(MyCoolEnum.PREVED));
			assertFalse(d.hasSignalListener(MyCoolEnum.BOGA));
			assertFalse(d.hasSignalListener(MyCoolEnum.SHALOM));

			assertTrue(d.isDisposed);
		}

		[Test]
		public function testHasSignalListener():void
		{

		}
	}
}
