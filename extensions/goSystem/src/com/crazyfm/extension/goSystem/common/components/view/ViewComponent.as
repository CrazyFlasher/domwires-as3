/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.view
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import starling.display.DisplayObjectContainer;

	public class ViewComponent extends GameComponent implements IViewComponent
	{
		private var displayObjectContainer:DisplayObjectContainer;

		public function ViewComponent(displayObjectContainer:DisplayObjectContainer)
		{
			super();

			this.displayObjectContainer = displayObjectContainer;
		}

		public function setPositions(x:Number, y:Number):IViewComponent
		{
			displayObjectContainer.x = x;
			displayObjectContainer.y = y;

			return this;
		}

		public function setDegreeRotation(angle:Number):IViewComponent
		{
			displayObjectContainer.rotation = angle * (Math.PI / 180);

			return this;
		}

		public function setRadianRotation(angle:Number):IViewComponent
		{
			displayObjectContainer.rotation = angle;

			return this;
		}

		public function get x():Number
		{
			return displayObjectContainer.x;
		}

		public function get y():Number
		{
			return displayObjectContainer.y;
		}

		public function get radianRotation():Number
		{
			return displayObjectContainer.rotation;
		}

		public function get degreeRotation():Number
		{
			return displayObjectContainer.rotation * 180 / Math.PI;
		}

		override public function dispose():void
		{
			displayObjectContainer = null;

			super.dispose();
		}
	}
}
