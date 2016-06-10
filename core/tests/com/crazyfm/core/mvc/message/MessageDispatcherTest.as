/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc.message
{
	import com.crazyfm.core.common.Enum;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;

	public class MessageDispatcherTest
	{

		private var d:MessageDispatcher;

		[Before]
		public function setUp():void
		{
			d = new MessageDispatcher();
		}

		[After]
		public function tearDown():void
		{
			d.dispose();
		}

		[Test]
		public function testDispatchMessage():void
		{
			var gotMessage:Boolean;
			var gotMessageType:Enum;
			var gotMessageTarget:IMessageDispatcher;
			var gotMessageData:Object = {};

			d.addMessageListener(MyCoolEnum.PREVED, function(event:IMessage):void{
				gotMessage = true;
				gotMessageType = event.type;
				gotMessageTarget = event.target as IMessageDispatcher;
				gotMessageData.prop = event.data.prop;
			});

			d.dispatchMessage(MyCoolEnum.PREVED, {prop:"prop1"});

			assertTrue(gotMessage);
			assertEquals(gotMessageType, MyCoolEnum.PREVED);
			assertEquals(gotMessageTarget, d);
			assertEquals(gotMessageData.prop, "prop1");
		}

		[Test]
		public function testAddMessageListener():void
		{
			assertFalse(d.hasMessageListener(MyCoolEnum.PREVED));
			d.addMessageListener(MyCoolEnum.PREVED, function(event:IMessage):void{});
			assertTrue(d.hasMessageListener(MyCoolEnum.PREVED));
		}

		[Test]
		public function testRemoveAllMessages():void
		{
			var listener:Function = function(event:IMessage):void{};
			d.addMessageListener(MyCoolEnum.PREVED, listener);
			d.addMessageListener(MyCoolEnum.BOGA, listener);
			assertTrue(d.hasMessageListener(MyCoolEnum.PREVED));
			assertTrue(d.hasMessageListener(MyCoolEnum.BOGA));

			d.removeAllMessageListeners();
			assertFalse(d.hasMessageListener(MyCoolEnum.PREVED));
			assertFalse(d.hasMessageListener(MyCoolEnum.BOGA));
		}

		[Test]
		public function testRemoveMessageListener():void
		{
			assertFalse(d.hasMessageListener(MyCoolEnum.PREVED));

			var listener:Function = function(event:IMessage):void{};
			d.addMessageListener(MyCoolEnum.PREVED, listener);
			assertTrue(d.hasMessageListener(MyCoolEnum.PREVED));
			assertFalse(d.hasMessageListener(MyCoolEnum.BOGA));

			d.addMessageListener(MyCoolEnum.BOGA, listener);
			d.removeMessageListener(MyCoolEnum.PREVED, listener);
			assertFalse(d.hasMessageListener(MyCoolEnum.PREVED));
			assertTrue(d.hasMessageListener(MyCoolEnum.BOGA));

			d.removeMessageListener(MyCoolEnum.BOGA, listener);
			assertFalse(d.hasMessageListener(MyCoolEnum.BOGA));
		}

		[Test]
		public function testDispose():void
		{
			d.addMessageListener(MyCoolEnum.PREVED, function(event:IMessage):void{});
			d.addMessageListener(MyCoolEnum.BOGA, function(event:IMessage):void{});
			d.addMessageListener(MyCoolEnum.SHALOM, function(event:IMessage):void{});
			d.dispose();

			assertFalse(d.hasMessageListener(MyCoolEnum.PREVED));
			assertFalse(d.hasMessageListener(MyCoolEnum.BOGA));
			assertFalse(d.hasMessageListener(MyCoolEnum.SHALOM));

			assertTrue(d.isDisposed);
		}

		[Test]
		public function testHasMessageListener():void
		{
			var listener:Function = function(event:IMessage):void{};
			d.addMessageListener(MyCoolEnum.PREVED, listener);
			assertTrue(d.hasMessageListener(MyCoolEnum.PREVED));
		}

		[Test]
		public function testEveryBodyReceivedMessage():void
		{
			var sr_1:IMessageDispatcher = new MessageDispatcher();
			var sr_2:IMessageDispatcher = new MessageDispatcher();

			var a:Boolean;
			var b:Boolean;

			var listener_1:Function = function(event:IMessage):void{a = true;};
			var listener_2:Function = function(event:IMessage):void{b = true;};

			d.addMessageListener(MyCoolEnum.PREVED, listener_1);
			d.addMessageListener(MyCoolEnum.PREVED, listener_2);

			d.dispatchMessage(MyCoolEnum.PREVED);

			assertTrue(a);
			assertTrue(b);
		}

		[Test]
		public function testEveryBodyReceivedEvent():void
		{
			var d:IEventDispatcher = new EventDispatcher();
			var sr_1:IEventDispatcher = new EventDispatcher();
			var sr_2:IEventDispatcher = new EventDispatcher();

			var a:Boolean;
			var b:Boolean;

			var listener_1:Function = function(event:Event):void{a = true;};
			var listener_2:Function = function(event:Event):void{b = true;};

			d.addEventListener("test", listener_1);
			d.addEventListener("test", listener_2);

			d.dispatchEvent(new Event("test"));

			assertTrue(a);
			assertTrue(b);
		}
	}
}
