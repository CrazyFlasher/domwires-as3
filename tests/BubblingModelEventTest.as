/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package
{
	import com.crazy.mvc.Context;
	import com.crazy.mvc.Model;
	import com.crazy.mvc.ModelContainer;

	public class BubblingModelEventTest
	{
		[Before]
		public function setUp():void
		{
			var c1:Context = new Context();
			var c2:Context = new Context();
			var mc1:ModelContainer = new ModelContainer();
			var mc2:ModelContainer = new ModelContainer();
			var m1:Model = new Model();

			mc2.addModel(m1);
			mc1.addModel(mc2);
			c2.addModel(mc1);
			c1.addModel(c2);

			m1.addModelEventListener("testEvent", function(type:String, data:Object = null){

			});
		}

		[Test]
		public function testBubbling():void
		{

		}

		[After]
		public function tearDown():void
		{

		}
	}
}
