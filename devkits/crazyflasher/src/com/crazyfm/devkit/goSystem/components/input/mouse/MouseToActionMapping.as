/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.input.mouse
{
	import com.crazyfm.core.common.Enum;

	public class MouseToActionMapping
	{
		private var _action:Enum;
		private var _mouseUp:Boolean;
		private var _mouseMove:Boolean;
		private var _mouseDown:Boolean;

		public function MouseToActionMapping(action:Enum, mouseUp:Boolean, mouseDown:Boolean, mouseMove:Boolean)
		{
			_action = action;
			_mouseUp = mouseUp;
			_mouseDown = mouseDown;
			_mouseMove = mouseMove;
		}

		public function get action():Enum
		{
			return _action;
		}

		public function get mouseUp():Boolean
		{
			return _mouseUp;
		}

		public function get mouseMove():Boolean
		{
			return _mouseMove;
		}

		public function get mouseDown():Boolean
		{
			return _mouseDown;
		}
	}
}
