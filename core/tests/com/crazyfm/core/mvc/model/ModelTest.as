/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazyfm.core.mvc.model
{
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

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
			assertNull(model.parent);

			var mc:ModelContainer = new ModelContainer();
			mc.addModel(model);
			assertNotNull(model.parent);

			mc.removeModel(model);
			assertNull(model.parent);

			mc.dispose();
		}

		[Test]
		public function testDispose():void
		{
			var mc:ModelContainer = new ModelContainer();
			mc.addModel(model);
			assertNotNull(model.parent);

			model.dispose();
			assertNull(model.parent);
			assertTrue(model.isDisposed);
		}
	}
}
