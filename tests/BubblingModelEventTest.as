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
		private var mc1:IModelContainer;
		private var mc2:IModelContainer;

		[Before]
		public function setUp():void
		{
			c1 = new Context();
			c2 = new Context();
			mc1 = new ModelContainer();
			mc2 = new ModelContainer();
			m1 = new Model();

			mc2.addModel(m1);
			mc1.addModel(mc2);
			c2.addModel(mc1);
			c1.addModel(c2);
		}

		[Test]
		public function testBubbling():void
		{
			var bubbledEventType:String;

			var successFunc:Function = function (event:ISignalEvent):void
			{
				bubbledEventType = event.type;
			}

			c1.bubbledSignalListener = successFunc;

			m1.dispatchSignal("testEventType", {name: "Anton"});

			Assert.assertEquals(bubbledEventType, "testEventType");
		}

		[After]
		public function tearDown():void
		{

		}
	}
}
