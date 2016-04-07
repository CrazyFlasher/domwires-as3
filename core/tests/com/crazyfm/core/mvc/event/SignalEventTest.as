/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazyfm.core.mvc.event
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;

	public class SignalEventTest
	{
		private var event:ISignalEvent;

		[Before]
		public function setUp():void
		{
			event = new SignalEvent(MyCoolEnum.PREVED, {name:"Anton"});
		}

		[After]
		public function tearDown():void
		{
			event.dispose();
		}

		[Test]
		public function testData():void
		{
			assertEquals(event.data.name, "Anton");
		}

		[Test]
		public function testType():void
		{
			assertEquals(event.type, MyCoolEnum.PREVED);
		}

		[Test]
		public function testDispose():void
		{
			event.dispose();
			assertNull(event.data, event.currentTarget, event.target);
			assertTrue(event.isDisposed);
		}
	}
}
