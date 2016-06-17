/**
 * Created by Anton Nefjodov on 4.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.camera
{
	import com.crazyfm.extension.gearSys.GearSysComponent;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class Camera extends GearSysComponent implements ICamera
	{
		[Autowired]
		public var viewContainer:DisplayObjectContainer;

		[Autowired]
		public var juggler:Juggler;

		private var transitionTime:Number;

		private var focusObject:DisplayObject;
		private var viewPort:Rectangle;
		private var tween:Tween;
		private var _aimPosition:Point = new Point();

		private var viewContainerBounds:Rectangle = new Rectangle();

		public function Camera(transitionTime:Number = 0.5)
		{
			super();

			this.transitionTime = transitionTime;
		}

		[PostConstruct]
		public function init():void
		{
			viewContainer.getBounds(viewContainer.parent, viewContainerBounds);

			if (transitionTime > 0)
			{
				tween = new Tween(viewContainer, transitionTime);
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
//					calculatePosition(viewPort.width, viewContainerBounds.width, focusObject.x, _aimPosition.x),
//					calculatePosition(viewPort.height, viewContainerBounds.height, focusObject.y, _aimPosition.y)
					calculatePosition(viewPort.width, viewContainerBounds.width, focusObject.x, focusObject.x),
					calculatePosition(viewPort.height, viewContainerBounds.height, focusObject.y, focusObject.y)
			);
		}

		private function calculatePosition(viewPortSize:Number, viewContainerSize:Number, focusObjectPosition:Number,
										   aimPosition:Number):Number
		{
			if (viewPortSize < viewContainerSize)
			{
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

				var position:Number = -(focusObjectPosition + diff) + viewPortSize / 2;

				if (position > 0)
				{
					position = 0;
				} /*else if (position < viewPortSize - viewContainerSize)
				{
					position = viewPortSize - viewContainerSize;
				}*/

				return position;
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

				if (!juggler.contains(tween))
				{
					juggler.add(tween);
				}
			}
		}

		public function setViewport(value:Rectangle):ICamera
		{
			viewPort = value;

			updateViewContainerBounds();

			return this;
		}

		override public function dispose():void
		{
			if (tween)
			{
				juggler.remove(tween);
				tween = null;
			}

			super.dispose();
		}

		public function updateViewContainerBounds():ICamera
		{
			viewContainer.getBounds(viewContainer.parent, viewContainerBounds);

			return this;
		}
	}
}
