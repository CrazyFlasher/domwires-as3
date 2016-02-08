/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.Context;
	import com.crazyfm.core.mvc.model.IModel;
	import com.crazyfm.core.mvc.model.IModelContainer;
	import com.crazyfm.core.mvc.model.Model;
	import com.crazyfm.core.mvc.model.ModelContainer;
	import com.crazyfm.core.mvc.view.IViewController;
	import com.crazyfm.core.mvc.view.ViewController;

	import flash.display.Sprite;

	import flexunit.framework.Assert;

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
			var v:IViewController = new ViewController(new Sprite());
			context.addViewController(v);
			context.removeViewController(v);
			Assert.assertEquals(context.numViewControllers, 0)
		}

		[Test]
		public function testNumViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewControllers(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViewControllers, 3);
		}

		[Test]
		public function testAddView():void
		{
			var v:IViewController = new ViewController(new Sprite());
			context.addViewController(v);
			Assert.assertEquals(context.numViewControllers, 1);
		}

		[Test]
		public function testRemoveAllViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewControllers(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViewControllers, 3);
			context.removeAllViewControllers();
			Assert.assertEquals(context.numViewControllers, 0)
		}

		[Test]
		public function testAddViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewControllers(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViewControllers, 3);
			Assert.assertTrue(context.containsViewController(v1));
			Assert.assertTrue(context.containsViewController(v2));
			Assert.assertTrue(context.containsViewController(v3));
		}

		[Test]
		public function testContainsView():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewControllers(new <IViewController>[v1, v2, v3]);
			Assert.assertTrue(context.containsViewController(v1));
			Assert.assertTrue(context.containsViewController(v2));
			Assert.assertTrue(context.containsViewController(v3));
		}

		[Test]
		public function testRemoveViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewControllers(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViewControllers, 3);
			context.removeViewControllers(new <IViewController>[v1, v2, v3]);
			Assert.assertEquals(context.numViewControllers, 0)
		}

		[Test]
		public function testDispose():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			var m1:IModel = new Model();
			var m2:IModel = new Model();
			var m3:IModel = new Model();
			context.addViewControllers(new <IViewController>[v1, v2, v3]);
			context.addModels(new <IModel>[m1, m2, m3]);
			context.dispose();

			Assert.assertEquals(context.numModels, 0);
			Assert.assertEquals(context.numViewControllers, 0);

			Assert.assertFalse(m1.isDisposed);
			Assert.assertFalse(m2.isDisposed);
			Assert.assertFalse(m3.isDisposed);
			Assert.assertFalse(v1.isDisposed);
			Assert.assertFalse(v2.isDisposed);
			Assert.assertFalse(v3.isDisposed);
		}

		[Test]
		public function testDisposeWithAllChildren():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			var m1:IModel = new Model();
			var m2:IModel = new Model();
			var m3:IModel = new Model();
			context.addViewControllers(new <IViewController>[v1, v2, v3]);
			context.addModels(new <IModel>[m1, m2, m3]);
			context.disposeWithAllChildren();

			Assert.assertEquals(context.numModels, 0);
			Assert.assertEquals(context.numViewControllers, 0);

			Assert.assertTrue(m1.isDisposed);
			Assert.assertTrue(m2.isDisposed);
			Assert.assertTrue(m3.isDisposed);
			Assert.assertTrue(v1.isDisposed);
			Assert.assertTrue(v2.isDisposed);
			Assert.assertTrue(v3.isDisposed);
		}

		[Test]
		public function testDispatchSignalToViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			var mc:IModelContainer = new ModelContainer();
			var m1:IModel = new Model();
			mc.addModel(m1);
			context.addModel(mc);
			context.addViewControllers(new <IViewController>[v1, v2, v3]);

			var viewsReceivedSignalCount:int;
			var listener:Function = function(event:ISignalEvent):void{
				viewsReceivedSignalCount++;
			};

			v1.addSignalListener("test", listener);
			v2.addSignalListener("test", listener);
			v3.addSignalListener("test", listener);

			m1.dispatchSignal("test");

			Assert.assertEquals(viewsReceivedSignalCount, 3);
		}

		[Test]
		public function receiveSignalFromViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewControllers(new <IViewController>[v1, v2, v3]);

			var receivedSignalFromViewsCount:int;
			var listener:Function = function(event:ISignalEvent):void{
				receivedSignalFromViewsCount++;
			};

			context.addSignalListener("test", listener);
			v1.dispatchSignal("test");
			v2.dispatchSignal("test");
			v3.dispatchSignal("test");

			Assert.assertEquals(receivedSignalFromViewsCount, 3);
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
