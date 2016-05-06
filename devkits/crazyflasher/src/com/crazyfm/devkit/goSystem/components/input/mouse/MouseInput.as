/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.input.mouse
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInput;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.input.ns_input;

	import flash.geom.Point;

	import starling.display.DisplayObjectContainer;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	use namespace ns_input;

	public class MouseInput extends AbstractInput
	{
		private var viewContainer:DisplayObjectContainer;
		private var mouseToActions:Vector.<MouseToActionMapping>;

		private var touch:Touch;

		private var mouseActionVo:MouseActionVo;

		private var touchPosition:Point = new Point();

		public function MouseInput(viewContainer:DisplayObjectContainer, mouseToActions:Vector.<MouseToActionMapping>)
		{
			super();

			this.viewContainer = viewContainer;
			this.mouseToActions = mouseToActions;

			viewContainer.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		override protected function createActionVo():void
		{
			actionVo = new MouseActionVo();

			mouseActionVo = actionVo as MouseActionVo;
		}

		override public function dispose():void
		{
			viewContainer.removeEventListener(TouchEvent.TOUCH, onTouch);

			viewContainer = null;
			mouseToActions = null;
			touch = null;
			mouseActionVo = null;

			super.dispose();
		}


		private function onTouch(event:TouchEvent):void
		{
			if (event.touches)
			{
				touch = event.touches[0];

				if (touch)
				{
					if (touch.phase == TouchPhase.HOVER)
					{
						touch.getLocation(viewContainer, touchPosition);
						tryToSendAction(false, false, true);
					}
				}
			}
		}

		private function tryToSendAction(mouseUp:Boolean, mouseDown:Boolean, mouseMove:Boolean):void
		{
			for each (var vo:MouseToActionMapping in mouseToActions)
			{
				if (vo.mouseMove == mouseMove && vo.mouseDown == mouseDown && vo.mouseUp == mouseUp)
				{
					sendActionToControllables(vo.action);
				}
			}
		}


		override protected function updateActionVo(action:Enum):AbstractInputActionVo
		{
			super.updateActionVo(action);

			mouseActionVo.setPosition(touchPosition.x, touchPosition.y);

			return actionVo;
		}
	}
}
