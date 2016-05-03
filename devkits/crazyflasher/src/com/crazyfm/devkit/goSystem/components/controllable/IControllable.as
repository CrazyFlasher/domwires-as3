/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.controllable
{
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IControllable extends IGameComponent
	{
		function inputAction(actionVo:AbstractInputActionVo):IControllable;
	}
}
