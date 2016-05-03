/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.input.keyboard
{
	import com.crazyfm.devkit.goSystem.components.input.*;

	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class KeyboardInput extends AbstractInput
	{
		private var keyDownList:Vector.<uint> = new <uint>[];
		private var stage:Stage;
		private var keysToActions:Vector.<KeysToActionMapping>;

		private var keyboardActionVo:KeyboardActionVo;

		public function KeyboardInput(stage:Stage, keysToActions:Vector.<KeysToActionMapping>)
		{
			super();

			this.stage = stage;
			this.keysToActions = keysToActions;

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		override protected function createActionVo():void
		{
			actionVo = new KeyboardActionVo();

			keyboardActionVo = actionVo as KeyboardActionVo;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			var keyCode:uint;
			for (var i:int = 0; i < keyDownList.length; i++)
			{
				keyCode = keyDownList[i];

				tryToApplyAction(keyCode, true);
			}
		}

		override public function dispose():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

			stage = null;
			keyDownList = null;
			keyboardActionVo = null;

			super.dispose();
		}

		private function keyUp(event:KeyboardEvent, keyCode:uint):void
		{
			var keyIndex:int = keyDownList.indexOf(keyCode);

			if (keyIndex != -1)
			{
				keyDownList.removeAt(keyIndex);

				tryToApplyAction(keyCode, false);
			}
		}

		private function keyDown(event:KeyboardEvent, keyCode:uint):void
		{
			if (keyDownList.indexOf(keyCode) == -1)
			{
				keyDownList.push(keyCode);
			}
		}

		private function keyIsDown(keyCode:uint):Boolean
		{
			return keyDownList.indexOf(keyCode) != -1;
		}

		private function tryToApplyAction(keyCode:uint, isDown:Boolean):void
		{
			var applyAction:Boolean;
			var keys:Vector.<uint>;

			for each (var vo:KeysToActionMapping in keysToActions)
			{
				keys = isDown ? vo.keysDown : vo.keysUp;

				if (keys != null)
				{
					if (keys.indexOf(keyCode) != -1)
					{
						applyAction = checkOtherActionKeys(keys, isDown);

						if (applyAction)
						{
							sendActionToControllables(vo.action);
						}
					}
				}
			}
		}

		private function checkOtherActionKeys(keys:Vector.<uint>, isDown:Boolean):Boolean
		{
			var currentKeyIsDown:Boolean;

			for (var i:int = 0; i < keys.length; i++)
			{
				currentKeyIsDown = keyIsDown(keys[i]);

				if (isDown != currentKeyIsDown)
				{
					return false;
				}
			}

			return true;
		}
	}
}
