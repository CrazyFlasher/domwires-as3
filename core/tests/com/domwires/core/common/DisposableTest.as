/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.domwires.core.common
{
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class DisposableTest
	{

		private var d:IDisposable;

		[Before]
		public function setUp():void
		{
			d = new AbstractDisposable();
		}

		[After]
		public function tearDown():void
		{
			if (!d.isDisposed)
			{
				d.dispose();	
			}
		}

		[Test]
		public function testDispose():void
		{
			assertFalse(d.isDisposed);
			d.dispose();
			assertTrue(d.isDisposed);
		}
	}
}
