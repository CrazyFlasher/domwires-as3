/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.message
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.mvc.context.AbstractContext;
	import com.crazyfm.core.mvc.model.AbstractModel;
	import com.crazyfm.core.mvc.model.ModelContainer;
	import com.crazyfm.core.mvc.view.AbstractView;

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
			c1 = new AbstractContext(AppFactory.getSingletonInstance());
			c2 = new AbstractContext(AppFactory.getSingletonInstance());
			c3 = new AbstractContext(AppFactory.getSingletonInstance());
			c4 = new AbstractContext(AppFactory.getSingletonInstance());
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

		[Test]
		public function testBubblingFromBottomToTop():void
		{
			var bubbledEventType:Enum;

			var successFunc:Function = function (event:IMessage):Boolean
			{
				//message came from bottom to top
				bubbledEventType = event.type;
				return true;
			};

			//top element
			c1.addMessageListener(MyCoolEnum.PREVED, successFunc);

			//bottom element
			m1.dispatchMessage(MyCoolEnum.PREVED, {name: "Anton"});

			assertEquals(bubbledEventType, MyCoolEnum.PREVED);

			/*bubbledEventType = null;

			//bottom element
			m1.dispatchMessage(MyCoolEnum.PREVED, {name: "Anton"});

			assertEquals(bubbledEventType, MyCoolEnum.PREVED);

			bubbledEventType = null;

			v1.dispatchMessage(MyCoolEnum.PREVED, {name: "Anton"});

			assertEquals(bubbledEventType, MyCoolEnum.PREVED);*/
		}

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
