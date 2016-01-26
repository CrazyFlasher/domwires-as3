/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package
{
	import com.crazy.starlingSample.mvc.contexts.SampleContext;
	import com.crazy.starlingSample.mvc.models.PhysicsModel;

	import starling.display.Sprite;

	public class SampleMain extends Sprite
	{
		public function SampleMain()
		{
			super();

			init();
		}

		private function init():void
		{
			trace("SampleMain: initialized!");

			var context:SampleContext = new SampleContext();

		}

	}
}
