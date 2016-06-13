/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazyfm.devkit.gearSys.components.input
{
	import com.crazyfm.core.common.Enum;

	use namespace ns_input;

	public class AbstractInputActionVo
	{
		private var _action:Enum;

		public function AbstractInputActionVo()
		{

		}

		public function get action():Enum
		{
			return _action;
		}

		ns_input function setAction(value:Enum):AbstractInputActionVo
		{
			_action = value;

			return this;
		}

		public function toString():String
		{
			return _action.toString();
		}

		public function clone():AbstractInputActionVo
		{
			return new AbstractInputActionVo().setAction(_action);
		}
	}
}
