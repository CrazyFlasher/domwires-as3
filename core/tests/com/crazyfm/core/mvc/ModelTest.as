/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazyfm.core.mvc
{
	import com.crazyfm.core.mvc.model.Model;
	import com.crazyfm.core.mvc.model.ModelContainer;

	import flexunit.framework.Assert;

	public class ModelTest
	{
		private var model:Model;

		[Before]
		public function setUp():void
		{
			model = new Model();
		}

		[After]
		public function tearDown():void
		{
			model.dispose();
		}

		[Test]
		public function testParent():void
		{
			Assert.assertNull(model.parent);

			var mc:ModelContainer = new ModelContainer();
			mc.addModel(model);
			Assert.assertNotNull(model.parent);

			mc.removeModel(model);
			Assert.assertNull(model.parent);

			mc.dispose();
		}

		[Test]
		public function testDispose():void
		{
			var mc:ModelContainer = new ModelContainer();
			mc.addModel(model);
			Assert.assertNotNull(model.parent);

			model.dispose();
			Assert.assertNull(model.parent);
			Assert.assertTrue(model.isDisposed);
		}
	}
}
