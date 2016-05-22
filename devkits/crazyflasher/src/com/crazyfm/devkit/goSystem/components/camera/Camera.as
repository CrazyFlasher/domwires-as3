/**
 * Created by Anton Nefjodov on 4.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.camera
{
	import com.crazyfm.extension.goSystem.GOSystemComponent;

	import flash.geom.Point;

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

		private var _aimPosition:Point = new Point();

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

		public function setAimPosition(x:Number, y:Number):ICamera
		{
			_aimPosition.x = x;
			_aimPosition.y = y;

			return this;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!viewPort) return;
			if (!focusObject) return;

			moveTo(
					calculatePosition(viewPort.width, viewContainer.width, focusObject.x, _aimPosition.x),
					calculatePosition(viewPort.height, viewContainer.height, focusObject.y, _aimPosition.y)
			);
		}

		private function calculatePosition(viewPortSize:Number, viewContainerSize:Number, focusObjectPosition:Number,
										   aimPosition:Number):Number
		{
			if (viewPortSize < viewContainerSize)
			{
				var position:Number = 0;

//				var diff:Number = _aimPosition.x - focusObject.x;
				var diff:Number;
				/*if (!isNaN(mousePosition))
				 {
				 diff = mousePosition - viewPortSize / 2;
				 } else
				 {*/
				diff = aimPosition - focusObjectPosition;
				/*}*/

				if (diff > viewPortSize / 2) diff = viewPortSize / 2;

				position = -(focusObjectPosition + diff) + viewPortSize / 2;

				if (position > 0)
				{
					position = 0;
				} else if (position < viewPortSize - viewContainerSize)
				{
					position = viewPortSize - viewContainerSize;
				}

				return position;
			}

			return 0;
		}

		protected function calculateY():Number
		{
			if (viewPort.height < viewContainer.height)
			{
				var y:Number = 0;

//				var diff:Number = _aimPosition.x - focusObject.x;
				var diff:Number = Starling.current.nativeStage.mouseY - viewPort.height / 2;
				if (diff > viewPort.height / 2) diff = viewPort.height / 2;

				y = -(focusObject.y + diff) + viewPort.height / 2;

				if (y > 0)
				{
					y = 0;
				} else if (y < viewPort.height - viewContainer.height)
				{
					y = viewPort.height - viewContainer.height;
				}

				return y;
			}

			return 0;
		}

		protected function calculateX():Number
		{
			if (viewPort.width < viewContainer.width)
			{
				var x:Number = 0;

//				var diff:Number = _aimPosition.x - focusObject.x;
				var diff:Number = Starling.current.nativeStage.mouseX - viewPort.width / 2;
				if (diff > viewPort.width / 2) diff = viewPort.width / 2;

				x = -(focusObject.x + diff) + viewPort.width / 2;

				if (x > 0)
				{
					x = 0;
				} else if (x < viewPort.width - viewContainer.width)
				{
					x = viewPort.width - viewContainer.width;
				}

				return x;
			}

			return 0;
		}

		private function moveTo(x:Number, y:Number):void
		{
			if (transitionTime == 0)
			{
				viewContainer.x = x;
				viewContainer.y = y;
			} else
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
