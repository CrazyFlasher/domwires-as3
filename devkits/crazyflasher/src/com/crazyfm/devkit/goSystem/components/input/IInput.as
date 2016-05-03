/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.input
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IInput extends IGameComponent
	{
		function sendActionToControllables(action:Enum):IInput;
	}
}
