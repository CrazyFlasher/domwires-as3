/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc
{
	import com.crazyfm.core.common.Disposable;
	import com.crazyfm.core.common.IDisposable;

	import flexunit.framework.Assert;

	public class DisposableTest
	{

		private var d:IDisposable;

		[Before]
		public function setUp():void
		{
			d = new Disposable();
		}

		[After]
		public function tearDown():void
		{
			d.dispose();
		}

		[Test]
		public function testDispose():void
		{
			Assert.assertFalse(d.isDisposed);
			d.dispose();
			Assert.assertTrue(d.isDisposed);
		}
	}
}