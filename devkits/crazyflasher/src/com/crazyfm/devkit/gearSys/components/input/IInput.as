/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.input
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	public interface IInput extends IGearSysComponent
	{
		function sendActionToControllables(action:Enum):IInput;
	}
}
