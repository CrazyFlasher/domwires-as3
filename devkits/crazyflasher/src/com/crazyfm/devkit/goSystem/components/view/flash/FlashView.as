/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.view.flash
{
	import com.crazyfm.extension.goSystem.GOSystemComponent;

	import flash.display.DisplayObjectContainer;

	public class FlashView extends GOSystemComponent
	{
		protected var viewContainer:DisplayObjectContainer;

		public function FlashView(viewContainer:DisplayObjectContainer)
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