/**
 * Created by Anton Nefjodov on 29.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.input
{
	public class KeysToActionVo
	{
		private var _keysDown:Vector.<uint>;
		private var _keysUp:Vector.<uint>;
		private var _action:AbstractInputActionEnum;

		public function KeysToActionVo(action:AbstractInputActionEnum, keysDown:Vector.<uint> = null, keysUp:Vector.<uint> = null)
		{
			_action = action;
			_keysDown = keysDown;
			_keysUp = keysUp;
		}

		internal function get keysDown():Vector.<uint>
		{
			return _keysDown;
		}

		internal function get keysUp():Vector.<uint>
		{
			return _keysUp;
		}

		internal function get action():AbstractInputActionEnum
		{
			return _action;
		}
	}
}
