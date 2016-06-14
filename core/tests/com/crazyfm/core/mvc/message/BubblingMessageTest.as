/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.message
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.mvc.context.AbstractContext;
	import com.crazyfm.core.mvc.context.IContext;
	import com.crazyfm.core.mvc.model.AbstractModel;
	import com.crazyfm.core.mvc.model.ModelContainer;
	import com.crazyfm.core.mvc.view.AbstractView;

	import flash.events.Event;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;

	public class BubblingMessageTest
	{
		private var m1:AbstractModel;
		private var c1:AbstractContext;
		private var c2:AbstractContext;
		private var c3:AbstractContext;
		private var c4:AbstractContext;
		private var mc1:ModelContainer;
		private var mc2:ModelContainer;
		private var mc3:ModelContainer;
		private var mc4:ModelContainer;
		private var v1:AbstractView;

		/**
		 * 			c1
		 * 		 /	|  \
		 * 		c2	c3	c4
		 * 		|	|	|
		 * 		mc1	mc3	mc4
		 * 		|
		 * 		mc2
		 * 		|
		 * 		m1
		 */

		[Before]
		public function setUp():void
		{
			c1 = new MyContext("c1", AppFactory.getSingletonInstance());
			c2 = new MyContext("c2",AppFactory.getSingletonInstance());
			c3 = new MyContext("c3",AppFactory.getSingletonInstance());
			c4 = new MyContext("c4",AppFactory.getSingletonInstance());
			mc1 = new ModelContainer();
			mc2 = new ModelContainer();
			mc3 = new ModelContainer();
			mc4 = new ModelContainer();
			m1 = new AbstractModel();
			v1 = new AbstractView();

			mc2.addModel(m1);
			mc1.addModel(mc2);
			c4.addModel(mc4);
			c3.addModel(mc3);
			c2.addModel(mc1);
			c1.add(c2);
			c1.add(c3);
			c1.add(c4);
			c1.addView(v1)
		}

//		[Ignore]
		[Test]
		public function testBubblingFromBottomToTop():void
		{
			var bubbledEventType:Enum;

			var successFunc:Function = function (event:IMessage):void
			{
				//message came from bottom to top
				bubbledEventType = event.type;
			};

			//top element
			c1.addMessageListener(MyCoolEnum.PREVED, successFunc);

			//bottom element
			m1.dispatchMessage(MyCoolEnum.PREVED, {name: "Anton"}, true);

			assertEquals(bubbledEventType, MyCoolEnum.PREVED);

			bubbledEventType = null;

			v1.dispatchMessage(MyCoolEnum.PREVED, {name: "Anton"}, true);

			assertEquals(bubbledEventType, MyCoolEnum.PREVED);
		}

		[Ignore]
		[Test]
		public function testBubblingFromBottomToTopPerf():void
		{
			var bubbledEventType:Enum;
			var count:int;

			var successFunc:Function = function (event:IMessage):void
			{
				//message came from bottom to top
				//count++;
				//bubbledEventType = event.type;
				//trace(event.currentTarget.name);
			};


			var c1:IContext = new MyContext("c1", AppFactory.getSingletonInstance());
			var c2:IContext = new MyContext("c2", AppFactory.getSingletonInstance());
			var c3:IContext = new MyContext("c3", AppFactory.getSingletonInstance());
			var c4:IContext = new MyContext("c4", AppFactory.getSingletonInstance());
			var c5:IContext = new MyContext("c5", AppFactory.getSingletonInstance());
			var c6:IContext = new MyContext("c6", AppFactory.getSingletonInstance());
			var c7:IContext = new MyContext("c7", AppFactory.getSingletonInstance());
			var c8:IContext = new MyContext("c8", AppFactory.getSingletonInstance());
			var c9:IContext = new MyContext("c9", AppFactory.getSingletonInstance());
			var c10:IContext = new MyContext("c10", AppFactory.getSingletonInstance());

			c1.addModel(
					c2.addModel(
							c3.addModel(
									c4.addModel(
											c5.addModel(
													c6.addModel(
															c7.addModel(
																	c8.addModel(
																			c9.addModel(
																					c10)))))))));


			for (var i:int = 0; i < 100000; i++)
			{
				count = 0;
				bubbledEventType = null;

				//top element
				c1.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c2.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c3.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c4.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c5.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c6.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c7.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c8.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c9.addMessageListener(MyCoolEnum.PREVED, successFunc);
				c10.addMessageListener(MyCoolEnum.PREVED, successFunc);

				//bottom element
				c10.dispatchMessage(MyCoolEnum.PREVED, {name: "Anton"}, false);

//				assertEquals(bubbledEventType, MyCoolEnum.PREVED);
//				assertEquals(count, 10);
			}
		}

		[Ignore]
		[Test]
		public function testBubblingFromBottomToTopPerfDisplayObject():void
		{
			var bubbledEventType:String;
			var count:int;

			var successFunc:Function = function (event:Event):void
			{
				//message came from bottom to top
//				count++;
//				bubbledEventType = event.type;
//				trace(event.currentTarget.name);
			};

			var d1:MyDisplayObjectContainer = new MyDisplayObjectContainer("d1");
			var d2:MyDisplayObjectContainer = new MyDisplayObjectContainer("d2");
			var d3:MyDisplayObjectContainer = new MyDisplayObjectContainer("d3");
			var d4:MyDisplayObjectContainer = new MyDisplayObjectContainer("d4");
			var d5:MyDisplayObjectContainer = new MyDisplayObjectContainer("d5");
			var d6:MyDisplayObjectContainer = new MyDisplayObjectContainer("d6");
			var d7:MyDisplayObjectContainer = new MyDisplayObjectContainer("d7");
			var d8:MyDisplayObjectContainer = new MyDisplayObjectContainer("d8");
			var d9:MyDisplayObjectContainer = new MyDisplayObjectContainer("d9");
			var d10:MyDisplayObjectContainer = new MyDisplayObjectContainer("d10");

			d1.addChild(d2);
			d2.addChild(d3);
			d3.addChild(d4);
			d4.addChild(d5);
			d5.addChild(d6);
			d6.addChild(d7);
			d7.addChild(d8);
			d8.addChild(d9);
			d9.addChild(d10);

			for (var i:int = 0; i < 500; i++)
			{
				count = 0;
				bubbledEventType = null;

				//top element

				d1.addEventListener("preved", successFunc);
				d2.addEventListener("preved", successFunc);
				d3.addEventListener("preved", successFunc);
				d4.addEventListener("preved", successFunc);
				d5.addEventListener("preved", successFunc);
				d6.addEventListener("preved", successFunc);
				d7.addEventListener("preved", successFunc);
				d8.addEventListener("preved", successFunc);
				d9.addEventListener("preved", successFunc);
				d10.addEventListener("preved", successFunc);

				//bottom element
				d10.dispatchEvent(new Event("preved", true));

//				assertEquals(bubbledEventType, "preved");
//				assertEquals(count, 10);
			}
		}

		[Ignore]
		[Test]
		public function testHierarchy():void
		{
			assertTrue(c3.parent == c1);
			assertTrue(mc3.parent == c3);
			assertTrue(mc4.parent == c4);
			assertTrue(m1.parent == mc2);
			assertTrue(m1.parent != mc1);
			assertTrue(mc2.parent == mc1);
			assertTrue(mc2.parent != c2);
			assertTrue(m1.parent != c1);
		}

		[After]
		public function tearDown():void
		{
			c1.dispose();
		}
	}
}

import com.crazyfm.core.factory.IAppFactory;
import com.crazyfm.core.mvc.context.AbstractContext;
import com.crazyfm.core.mvc.message.IMessage;

import flash.display.Sprite;

internal class MyContext extends AbstractContext
{
	private var _name:String;

	public function MyContext(name:String, f:IAppFactory)
	{
		_name = name;

		super(f);
	}

	override public function onMessageBubbled(message:IMessage):Boolean
	{
		super.onMessageBubbled(message);

		//bubble up!
		return true;
	}

	public function get name():String
	{
		return _name;
	}
}

internal class MyDisplayObjectContainer extends Sprite
{
	private var _name:String;

	public function MyDisplayObjectContainer(name:String)
	{
		super();
		_name = name;
	}

	override public function get name():String
	{
		return _name;
	}
}
