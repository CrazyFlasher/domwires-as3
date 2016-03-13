/**
 * Created by Anton Nefjodov on 12.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.view
{
	import com.crazyfm.extension.goSystem.common.components.physics.IPhysicsObjectComponent;

	import starling.display.DisplayObjectContainer;

	public class PhysicsViewComponent extends ViewComponent implements IPhysicsViewComponent
	{
		private var _physicsObjectComponent:IPhysicsObjectComponent;

		public function PhysicsViewComponent(displayObjectContainer:DisplayObjectContainer)
		{
			super(displayObjectContainer);
		}

		public function set physicsObjectComponent(value:IPhysicsObjectComponent):void
		{
			_physicsObjectComponent = value;
		}

		override public function dispose():void
		{
			_physicsObjectComponent = null;

			super.dispose();
		}
	}
}
