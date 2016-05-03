/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.input
{
	import com.crazyfm.core.common.Enum;

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
	}
}
