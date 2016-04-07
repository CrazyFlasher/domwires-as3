/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.IModel;
	import com.crazyfm.core.mvc.model.IModelContainer;
	import com.crazyfm.core.mvc.model.Model;
	import com.crazyfm.core.mvc.model.ModelContainer;
	import com.crazyfm.core.mvc.view.IViewController;
	import com.crazyfm.core.mvc.view.ViewController;

	import flash.display.Sprite;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;

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
			assertEquals(context.numViewControllers, 0)
		}

		[Test]
		public function testNumViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewController(v1).addViewController(v2).addViewController(v3);
			assertEquals(context.numViewControllers, 3);
		}

		[Test]
		public function testAddView():void
		{
			var v:IViewController = new ViewController(new Sprite());
			context.addViewController(v);
			assertEquals(context.numViewControllers, 1);
		}

		[Test]
		public function testRemoveAllViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewController(v1).addViewController(v2).addViewController(v3);
			assertEquals(context.numViewControllers, 3);
			context.removeAllViewControllers();
			assertEquals(context.numViewControllers, 0)
		}

		[Test]
		public function testAddViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewController(v1).addViewController(v2).addViewController(v3);
			assertEquals(context.numViewControllers, 3);
			assertTrue(context.containsViewController(v1));
			assertTrue(context.containsViewController(v2));
			assertTrue(context.containsViewController(v3));
		}

		[Test]
		public function testContainsView():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewController(v1).addViewController(v2).addViewController(v3);
			assertTrue(context.containsViewController(v1));
			assertTrue(context.containsViewController(v2));
			assertTrue(context.containsViewController(v3));
		}

		[Test]
		public function testRemoveViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewController(v1).addViewController(v2).addViewController(v3);
			assertEquals(context.numViewControllers, 3);
			context.removeViewController(v1).removeViewController(v2).removeViewController(v3);
			assertEquals(context.numViewControllers, 0)
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
			context.addViewController(v1).addViewController(v2).addViewController(v3);
			context.addModel(m1).addModel(m2).addModel(m3);
			context.dispose();

			assertEquals(context.numModels, 0);
			assertEquals(context.numViewControllers, 0);

			assertFalse(m1.isDisposed);
			assertFalse(m2.isDisposed);
			assertFalse(m3.isDisposed);
			assertFalse(v1.isDisposed);
			assertFalse(v2.isDisposed);
			assertFalse(v3.isDisposed);
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
			context.addViewController(v1).addViewController(v2).addViewController(v3);
			context.addModel(m1).addModel(m2).addModel(m3);
			context.disposeWithAllChildren();

			assertEquals(context.numModels, 0);
			assertEquals(context.numViewControllers, 0);

			assertTrue(m1.isDisposed);
			assertTrue(m2.isDisposed);
			assertTrue(m3.isDisposed);
			assertTrue(v1.isDisposed);
			assertTrue(v2.isDisposed);
			assertTrue(v3.isDisposed);
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
			context.addViewController(v1).addViewController(v2).addViewController(v3);

			var viewsReceivedSignalCount:int;
			var listener:Function = function(event:ISignalEvent):void{
				viewsReceivedSignalCount++;
			};

			v1.addSignalListener(MyCoolEnum.PREVED, listener);
			v2.addSignalListener(MyCoolEnum.PREVED, listener);
			v3.addSignalListener(MyCoolEnum.PREVED, listener);

			m1.dispatchSignal(MyCoolEnum.PREVED);

			assertEquals(viewsReceivedSignalCount, 3);
		}

		[Test]
		public function receiveSignalFromViews():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var v2:IViewController = new ViewController(new Sprite());
			var v3:IViewController = new ViewController(new Sprite());
			context.addViewController(v1).addViewController(v2).addViewController(v3);

			var receivedSignalFromViewsCount:int;
			var listener:Function = function(event:ISignalEvent):void{
				receivedSignalFromViewsCount++;
			};

			context.addSignalListener(MyCoolEnum.PREVED, listener);
			v1.dispatchSignal(MyCoolEnum.PREVED);
			v2.dispatchSignal(MyCoolEnum.PREVED);
			v3.dispatchSignal(MyCoolEnum.PREVED);

			assertEquals(receivedSignalFromViewsCount, 3);
		}

		[Test]
		public function testViewAddedToNewParent():void
		{
			var v1:IViewController = new ViewController(new Sprite());
			var c2:IContext = new Context();

			assertNull(v1.parent);

			context.addViewController(v1);
			assertEquals(v1.parent, context);

			c2.addViewController(v1);
			assertEquals(v1.parent, c2);

			assertEquals(context.numViewControllers, 0);

			c2.disposeWithAllChildren();
		}
	}
}
