/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.controllable
{
	import com.crazyfm.devkit.gearSys.components.input.AbstractInputActionVo;
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	public interface IControllable extends IGearSysComponent
	{
		function inputAction(actionVo:AbstractInputActionVo):IControllable;
	}
}
