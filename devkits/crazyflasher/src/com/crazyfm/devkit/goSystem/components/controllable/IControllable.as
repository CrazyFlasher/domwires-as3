/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.controllable
{
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionEnum;
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IControllable extends IGameComponent
	{
		function inputAction(action:AbstractInputActionEnum):IControllable;
	}
}
