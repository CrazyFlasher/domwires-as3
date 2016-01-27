/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package
{
	import com.crazy.mvc.Context;
	import com.crazy.mvc.Model;
	import com.crazy.mvc.ModelContainer;

import org.flexunit.Assert;

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

		[Test(async, timeout="3000")]
		public function testBubbling():void
		{
			/*handleSignal(this, c1.events, function(event:SignalAsyncEvent, data:Object = null):void{
				trace("onSignal");
			}, 500, {name:"Anton"});*/

			var bubbledCount:int;
			mc2.addModelEventListener("testEventType", function(...rest):void {
				bubbledCount++;
			});



			m1.dispatch("testEventType");
		}

		[After]
		public function tearDown():void
		{

		}
	}
}
