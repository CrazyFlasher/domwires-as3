/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.view.starling
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import starling.display.DisplayObjectContainer;

	public class StarlingView extends GameComponent
	{
		protected var viewContainer:DisplayObjectContainer;

		public function StarlingView(viewContainer:DisplayObjectContainer)
		{
			this.viewContainer = viewContainer;
		}

		override public function dispose():void
		{
			viewContainer = null;

			super.dispose();
		}
	}
}
