/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.model.Context;
	import com.crazy.mvc.model.IModel;
	import com.crazy.mvc.model.Model;
	import com.crazy.mvc.view.IViewController;
	import com.crazy.mvc.view.StarlingView;

	import flexunit.framework.Assert;

	import starling.display.Sprite;

	public class ContextTest
	{
		private var context:Context;

		[Before]
		public function setUp():void
		{
			context = new Context();
		}

		[After]
		public function tearDown():void
		{
			context.disposeWithAllChildren();
		}

		[Test]
		public function testRemoveView():void
		{
			var v:IViewController = new StarlingView(new Sprite());
			context.addView(v);
			context.removeView(v);
			Assert.assertEquals(context.numViews, 0)
		}

		[Test]
		public function testNumViews():void
		{
			var v1:IViewController = new StarlingView(new Sprite());
			var v2:IViewController = new StarlingView(new Sprite());
			var v3:IViewController = new StarlingView(new Sprite());
			context.addViews(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 3);
		}

		[Test]
		public function testAddView():void
		{
			var v:IViewController = new StarlingView(new Sprite());
			context.addView(v);
			Assert.assertEquals(context.numViews, 1);
		}

		[Test]
		public function testRemoveAllViews():void
		{
			var v1:IViewController = new StarlingView(new Sprite());
			var v2:IViewController = new StarlingView(new Sprite());
			var v3:IViewController = new StarlingView(new Sprite());
			context.addViews(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 3);
			context.removeAllViews();
			Assert.assertEquals(context.numViews, 0)
		}

		[Test]
		public function testAddViews():void
		{
			var v1:IViewController = new StarlingView(new Sprite());
			var v2:IViewController = new StarlingView(new Sprite());
			var v3:IViewController = new StarlingView(new Sprite());
			context.addViews(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 3);
			Assert.assertTrue(context.containsView(v1));
			Assert.assertTrue(context.containsView(v2));
			Assert.assertTrue(context.containsView(v3));
		}

		[Test]
		public function testContainsView():void
		{
			var v1:IViewController = new StarlingView(new Sprite());
			var v2:IViewController = new StarlingView(new Sprite());
			var v3:IViewController = new StarlingView(new Sprite());
			context.addViews(new <IViewController>[v1, v2, v3]);
			Assert.assertTrue(context.containsView(v1));
			Assert.assertTrue(context.containsView(v2));
			Assert.assertTrue(context.containsView(v3));
		}

		[Test]
		public function testRemoveViews():void
		{
			var v1:IViewController = new StarlingView(new Sprite());
			var v2:IViewController = new StarlingView(new Sprite());
			var v3:IViewController = new StarlingView(new Sprite());
			context.addViews(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 3);
			context.removeViews(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 0)
		}

		[Test]
		public function disposeWithAllChildren():void
		{
			var v1:IViewController = new StarlingView(new Sprite());
			var v2:IViewController = new StarlingView(new Sprite());
			var v3:IViewController = new StarlingView(new Sprite());
			var m1:IModel = new Model();
			var m2:IModel = new Model();
			var m3:IModel = new Model();
			context.addViews(new <IViewController>[v1, v2, v3]);
			context.addModels(new <IModel>[m1, m2, m3]);
			context.disposeWithAllChildren();

			Assert.assertEquals(context.numModels, 0);
			Assert.assertEquals(context.numViews, 0);
		}

		/*[Test]
		public function testMapSignalTypeToCommand():void
		{
			context.mapSignalTypeToCommand("test", MockCommand);

		}

		[Test]
		public function testContainsSignalToCommandMapping():void
		{
			context.mapSignalTypeToCommand("test", MockCommand);
			Assert.assertTrue(context.containsSignalToCommandMapping("test", MockCommand));
		}

		[Test]
		public function testUnmapSignalTypeFromCommand():void
		{

		}*/
	}
}
