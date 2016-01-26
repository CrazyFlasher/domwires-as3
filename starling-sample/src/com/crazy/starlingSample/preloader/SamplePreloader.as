/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.starlingSample.preloader
{
	import com.crazy.preloader.AppPreloader;
	import com.crazy.starlingSample.app.SampleStarlingApp;

	import flash.utils.getDefinitionByName;

	[SWF(width = "640", height = "480", frameRate = "60", backgroundColor = "#000000")]
	public class SamplePreloader extends AppPreloader
	{
		private var _app:SampleStarlingApp;

		public function SamplePreloader()
		{
			super();
		}

		override protected function appLoaded():void
		{
			super.appLoaded();

			var SAClass:Class = getDefinitionByName("com.crazy.starlingSample.app.SampleStarlingApp") as Class;
			var SMClass:Class = getDefinitionByName("SampleMain") as Class;

			_app = new SAClass(SMClass);
			addChild(_app);
		}
	}
}
