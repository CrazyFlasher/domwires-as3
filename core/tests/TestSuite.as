/**
 * Created by Anton Nefjodov on 2.02.2016.
 */
package
{
	import com.crazyfm.core.common.AppFactoryTest;
	import com.crazyfm.core.common.DisposableTest;
	import com.crazyfm.core.common.EnumTest;
	import com.crazyfm.core.mvc.event.BubblingEventTest;
	import com.crazyfm.core.mvc.event.SignalDispatcherTest;
	import com.crazyfm.core.mvc.event.SignalEventTest;
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainerTest;
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectTest;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;

	public class TestSuite extends Sprite
	{
		public static const ALL_TESTS:Array = [
			BubblingEventTest,
			DisposableTest,
			HierarchyObjectContainerTest,
			HierarchyObjectTest,
			SignalDispatcherTest,
			SignalEventTest,
			EnumTest,
			TestLog,
			AppFactoryTest
		];

		private var _flexunit:FlexUnitCore;

		public function TestSuite()
		{
			if(this.stage)
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
			this._flexunit.run(ALL_TESTS);
		}

		private function flexunit_testsCompleteHandler(event:Event):void
		{
//			System.exit(0);
		}
	}
}
