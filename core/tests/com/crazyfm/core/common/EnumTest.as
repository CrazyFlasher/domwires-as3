/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.core.common
{
	import org.flexunit.asserts.assertEquals;

	import testObject.MyCoolEnum;

	public class EnumTest
	{
		[Before]
		public function setUp():void
		{

		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testName():void
		{
			assertEquals(MyCoolEnum.PREVED.name, "preved");
		}
	}
}