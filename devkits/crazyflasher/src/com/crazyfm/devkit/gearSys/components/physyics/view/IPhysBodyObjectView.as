/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.physyics.view
{
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	import starling.display.DisplayObject;

	public interface IPhysBodyObjectView extends IGearSysComponent
	{
		function get skin():DisplayObject;
	}
}
