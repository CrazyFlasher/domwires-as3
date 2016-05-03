/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.input.mouse
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInput;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.input.ns_input;

	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	use namespace ns_input;

	public class MouseInput extends AbstractInput
	{
		private var stage:Stage;
		private var mouseToActions:Vector.<MouseToActionMapping>;

		private var touch:Touch;

		private var mouseActionVo:MouseActionVo;

		private var touchPosX:Number;
		private var touchPosY:Number;

		public function MouseInput(stage:Stage, mouseToActions:Vector.<MouseToActionMapping>)
		{
			super();

			this.stage = stage;
			this.mouseToActions = mouseToActions;

			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		override protected function createActionVo():void
		{
			actionVo = new MouseActionVo();

			mouseActionVo = actionVo as MouseActionVo;
		}

		override public function dispose():void
		{
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);

			stage = null;
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
					touchPosX = touch.globalX;
					touchPosY = touch.globalY;

					if (touch.phase == TouchPhase.HOVER)
					{
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

			mouseActionVo.setPosition(touchPosX, touchPosY);

			return actionVo;
		}
	}
}
