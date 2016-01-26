/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.starlingSample.mvc.contexts
{
	import com.crazy.mvc.Context;
	import com.crazy.starlingSample.mvc.models.PhysicsModel;

	public class SampleContext extends Context
	{
		public function SampleContext()
		{
			super();

			init();
		}

		private function init():void
		{
			var physModel:PhysicsModel = new PhysicsModel();
			physModel.addModelEventListener("wallHit", physModelEventHandler);
			addModel(physModel);
		}

		private function physModelEventHandler(eventType:String, data:Object = null):void
		{
			trace("SampleContext: physModelEventHandler ", eventType, data);
		}
	}
}
