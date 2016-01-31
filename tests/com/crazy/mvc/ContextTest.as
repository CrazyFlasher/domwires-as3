/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IContext;
	import com.crazy.mvc.api.IView;

	import flexunit.framework.Assert;

	import starling.display.Sprite;

	public class ContextTest
	{
		private var context:IContext;

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
			var v:IView = new StarlingView(new Sprite());
			context.addView(v);
			context.removeView(v);
			Assert.assertEquals(context.numViews, 0)
		}

		[Test]
		public function testNumViews():void
		{
			var v1:IView = new StarlingView(new Sprite());
			var v2:IView = new StarlingView(new Sprite());
			var v3:IView = new StarlingView(new Sprite());
			context.addViews(new <IView>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 3);
		}

		[Test]
		public function testAddView():void
		{
			var v:IView = new StarlingView(new Sprite());
			context.addView(v);
			Assert.assertEquals(context.numViews, 1);
		}

		[Test]
		public function testRemoveAllViews():void
		{
			var v1:IView = new StarlingView(new Sprite());
			var v2:IView = new StarlingView(new Sprite());
			var v3:IView = new StarlingView(new Sprite());
			context.addViews(new <IView>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 3);
			context.removeAllViews();
			Assert.assertEquals(context.numViews, 0)
		}

		[Test]
		public function testAddViews():void
		{
			var v1:IView = new StarlingView(new Sprite());
			var v2:IView = new StarlingView(new Sprite());
			var v3:IView = new StarlingView(new Sprite());
			context.addViews(new <IView>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 3);
			Assert.assertTrue(context.containsView(v1));
			Assert.assertTrue(context.containsView(v2));
			Assert.assertTrue(context.containsView(v3));
		}

		[Test]
		public function testContainsView():void
		{
			var v1:IView = new StarlingView(new Sprite());
			var v2:IView = new StarlingView(new Sprite());
			var v3:IView = new StarlingView(new Sprite());
			context.addViews(new <IView>[v1, v2, v3]);
			Assert.assertTrue(context.containsView(v1));
			Assert.assertTrue(context.containsView(v2));
			Assert.assertTrue(context.containsView(v3));
		}

		[Test]
		public function testRemoveViews():void
		{
			var v1:IView = new StarlingView(new Sprite());
			var v2:IView = new StarlingView(new Sprite());
			var v3:IView = new StarlingView(new Sprite());
			context.addViews(new <IView>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 3);
			context.removeViews(new <IView>[v1, v2, v3]);
			Assert.assertEquals(context.numViews, 0)
		}
	}
}
