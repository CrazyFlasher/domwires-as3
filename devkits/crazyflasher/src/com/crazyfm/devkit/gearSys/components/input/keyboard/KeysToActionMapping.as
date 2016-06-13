/**
 * Created by Anton Nefjodov on 29.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.input.keyboard
{
	import com.crazyfm.core.common.Enum;

	public class KeysToActionMapping
	{
		private var _keysDown:Vector.<uint>;
		private var _keysUp:Vector.<uint>;
		private var _action:Enum;

		public function KeysToActionMapping(action:Enum, keysDown:Vector.<uint> = null, keysUp:Vector.<uint> = null)
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

		internal function get action():Enum
		{
			return _action;
		}
	}
}
