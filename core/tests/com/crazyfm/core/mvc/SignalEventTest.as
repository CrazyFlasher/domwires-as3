/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazyfm.core.mvc
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.event.SignalEvent;

	import flexunit.framework.Assert;

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
			Assert.assertEquals(event.data.name, "Anton");
		}

		[Test]
		public function testType():void
		{
			Assert.assertEquals(event.type, MyCoolEnum.PREVED);
		}

		[Test]
		public function testDispose():void
		{
			event.dispose();
			Assert.assertNull(event.data, event.currentTarget, event.target);
			Assert.assertTrue(event.isDisposed);
		}
	}
}
