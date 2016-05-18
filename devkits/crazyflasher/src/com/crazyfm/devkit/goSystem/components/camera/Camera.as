/**
 * Created by Anton Nefjodov on 4.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.camera
{
	import com.crazyfm.extension.goSystem.GOSystemComponent;

	import flash.geom.Rectangle;

	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class Camera extends GOSystemComponent implements ICamera
	{
		private var focusObject:DisplayObject;

		private var viewPort:Rectangle;

		private var viewContainer:DisplayObject;

		private var tween:Tween;

		private var transitionTime:Number;

		public function Camera(viewContainer:DisplayObject, transitionTime:Number = 1.0)
		{
			super();

			this.viewContainer = viewContainer;
			this.transitionTime = transitionTime;

			if (transitionTime > 0)
			{
				tween = new Tween(viewContainer, transitionTime);
				Starling.juggler.add(tween);
			}
		}

		public function setFocusObject(value:DisplayObject):ICamera
		{
			focusObject = value;

			return this;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!viewPort) return;
			if (!focusObject) return;

			var x:Number = 0;
			var y:Number = 0;

			if (viewPort.width < viewContainer.width)
			{
				x = -focusObject.x + viewPort.width / 2;
			}

			if (viewPort.height < viewContainer.height)
			{
				y = -focusObject.y + viewPort.height / 2;
			}

			if (x > 0)
			{
				x = 0;
			}else
			if (x < viewPort.width - viewContainer.width)
			{
				x = viewPort.width - viewContainer.width;
			}

			moveTo(x, y);
		}

		private function moveTo(x:Number, y:Number):void
		{
			if (transitionTime == 0)
			{
				viewContainer.x = x;
				viewContainer.y = y;
			}else
			{
				tween.reset(viewContainer, transitionTime);
				tween.moveTo(x, y);
			}
		}

		public function setViewport(value:Rectangle):ICamera
		{
			viewPort = value;

			return this;
		}

		override public function dispose():void
		{
			if (tween)
			{
				Starling.juggler.remove(tween);
				tween = null;
			}

			super.dispose();
		}
	}
}
