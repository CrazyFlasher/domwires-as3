/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.view.flash
{
	import com.crazyfm.devkit.goSystem.components.physyics.view.IPhysDebugView;
	import com.crazyfm.devkit.goSystem.components.view.flash.FlashView;

	import flash.display.DisplayObjectContainer;

	import nape.space.Space;
	import nape.util.BitmapDebug;

	public class PhysDebugView extends FlashView implements IPhysDebugView
	{
		private var debug:BitmapDebug;
		private var space:Space;

		public function PhysDebugView(space:Space, viewContainer:DisplayObjectContainer)
		{
			super(viewContainer);

			this.space = space;

			createDebugDraw();
		}

		private function createDebugDraw():void
		{
			debug = new BitmapDebug(viewContainer.stage.stageWidth, viewContainer.stage.stageHeight, 0x000000, false);
			debug.drawCollisionArbiters = true;
			debug.drawConstraints = true;
			viewContainer.addChild(debug.display);
		}

		override public function dispose():void
		{
			removeDebugDraw();

			space = null;

			super.dispose();
		}

		private function removeDebugDraw():void
		{
			viewContainer.removeChild(debug.display);
			debug = null;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (debug)
			{
				debug.clear();
				debug.draw(space);
				debug.flush();
			}
		}
	}
}
