/**
 * Created by CrazyFlasher on 3.10.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.core.mvc.model.AbstractModel;
	import com.crazyfm.core.mvc.view.AbstractView;

	import org.flexunit.asserts.assertTrue;

	public class AbstractContextTest
	{
		private var c:IContext;

		[Before]
		public function setUp():void
		{
			var f:IAppFactory = new AppFactory();
			f.mapToType(IContext, AbstractContext);
			f.mapToValue(IAppFactory, f);
			
			c = f.getInstance(IContext);
			c.addModel(new AbstractModel());
			c.addView(new AbstractView());
		}

		[After]
		public function tearDown():void
		{
			if (!c.isDisposed)
			{
				c.disposeWithAllChildren();
			}
		}

		[Test]
		public function testDisposeWithAllChildren():void
		{
			c.disposeWithAllChildren();

			assertTrue(c.isDisposed);
		}
	}
}
