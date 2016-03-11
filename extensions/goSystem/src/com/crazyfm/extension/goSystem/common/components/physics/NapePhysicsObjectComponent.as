/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.physics
{
	import com.crazyfm.extension.goSystem.GameComponent;
	import com.crazyfm.extension.goSystem.common.components.view.IViewComponent;

	import nape.callbacks.InteractionCallback;

	public class NapePhysicsObjectComponent extends GameComponent implements INapePhysicsObjectComponent
	{
		private var view:IViewComponent;

		public function NapePhysicsObjectComponent()
		{
			super();
		}

		public function onBodyBeginCollision(collision:InteractionCallback):void
		{

		}

		override public function advanceTime(time:Number):void
		{
			super.advanceTime(time);

			//TODO: update view
		}

		public function setView(value:IViewComponent):INapePhysicsObjectComponent
		{
			view = value;

			return this;
		}


		override public function dispose():void
		{
			view = null;

			super.dispose();
		}
	}
}
