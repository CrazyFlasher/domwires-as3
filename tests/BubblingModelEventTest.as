/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package
{
	import com.crazy.mvc.Context;
	import com.crazy.mvc.Model;
	import com.crazy.mvc.ModelContainer;
	import com.crazy.mvc.api.IContext;
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;
	import com.crazy.mvc.api.ISignalEvent;

	import flexunit.framework.Assert;


	public class BubblingModelEventTest
	{
		private var m1:IModel;
		private var c1:IContext;
		private var c2:IContext;
		private var c3:IContext;
		private var c4:IContext;
		private var mc1:IModelContainer;
		private var mc2:IModelContainer;
		private var mc3:IModelContainer;
		private var mc4:IModelContainer;

		/**
		 * 			c1
		 * 			|
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
			c1 = new Context();
			c2 = new Context();
			c3 = new Context();
			c4 = new Context();
			mc1 = new ModelContainer();
			mc2 = new ModelContainer();
			mc3 = new ModelContainer();
			mc4 = new ModelContainer();
			m1 = new Model();

			mc2.addModel(m1);
			mc1.addModel(mc2);
			c2.addModel(mc1);
			c1.addModel(c2);
			c1.addModel(c3);
			c1.addModel(c4);
		}

		[Test]
		public function testBubblingFromBottomToTop():void
		{
			var bubbledEventType:String;

			var successFunc:Function = function (event:ISignalEvent):Boolean
			{
				bubbledEventType = event.type;
				return true;
			}

			//top element
			c1.addSignalListener("testEventType", successFunc);

			//bottom elementt
			m1.dispatchSignal("testEventType", {name: "Anton"});

			Assert.assertEquals(bubbledEventType, "testEventType");
		}

		[After]
		public function tearDown():void
		{
			c1.dispose();
		}
	}
}
