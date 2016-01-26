/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.starlingSample.app
{
	import com.crazy.app.StarlingApp;

	import flash.events.UncaughtErrorEvent;

	public class SampleStarlingApp extends StarlingApp
	{
		public function SampleStarlingApp(rootClass:Class)
		{
			super(rootClass);
		}

		override public function handleUncaughtError(event:UncaughtErrorEvent):void
		{

		}
	}
}
