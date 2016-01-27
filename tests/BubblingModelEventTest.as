/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package
{
	import com.crazy.mvc.Context;
	import com.crazy.mvc.Model;
	import com.crazy.mvc.ModelContainer;

	import org.osflash.signals.utils.SignalAsyncEvent;

	import org.osflash.signals.utils.handleSignal;

	public class BubblingModelEventTest
	{
		private var m1:Model;
		private var c1:Context;
		private var c2:Context;
		private var mc1:ModelContainer;
		private var mc2:ModelContainer;

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

		[Test(async)]
		public function testBubbling():void
		{
			/*handleSignal(this, m1.events, function(event:SignalAsyncEvent, data:Object = null):void{
				trace("onSignal");
			}, 500, {name:"Anton"});*/


			mc2.addModelEventListener("testEventType", function(type:String, data:Object = null):void {
				trace("Signal bubbled");
			});

			m1.dispatch("testEventType");
		}

		[After]
		public function tearDown():void
		{

		}
	}
}
