/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.controllable
{
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	public interface IControllable extends IGOSystemComponent
	{
		function inputAction(actionVo:AbstractInputActionVo):IControllable;
	}
}
