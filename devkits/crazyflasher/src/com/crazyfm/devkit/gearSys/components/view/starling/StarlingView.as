/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.view.starling
{
	import com.crazyfm.extension.gearSys.GearSysComponent;

	import starling.display.DisplayObjectContainer;

	public class StarlingView extends GearSysComponent
	{
		[Autowired]
		public var viewContainer:DisplayObjectContainer;

		public function StarlingView()
		{
			super();
		}

		override public function dispose():void
		{
			viewContainer = null;

			super.dispose();
		}
	}
}
