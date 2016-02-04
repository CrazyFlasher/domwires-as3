/**
 * Created by Anton Nefjodov on 2.02.2016.
 */
package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.System;

	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;

	public class TestSuite extends Sprite
	{
		public static const ALL_TESTS:Array = [
		];

		private var _flexunit:FlexUnitCore;

		public function TestSuite()
		{
			if (this.stage)
			{
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
			}

			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}

		private function loaderInfo_completeHandler(event:Event):void
		{
			this._flexunit = new FlexUnitCore();
			this._flexunit.addListener(new TraceListener());
			this._flexunit.addListener(new CIListener());
			this._flexunit.addEventListener(FlexUnitCore.TESTS_COMPLETE, flexunit_testsCompleteHandler);
			this._flexunit.addEventListener(FlexUnitCore.TESTS_STOPPED, flexunit_testsCompleteHandler);

			this._flexunit.run(ALL_TESTS);
		}

		private function flexunit_testsCompleteHandler(event:Event = null):void
		{
			System.exit(0);
		}
	}
}
