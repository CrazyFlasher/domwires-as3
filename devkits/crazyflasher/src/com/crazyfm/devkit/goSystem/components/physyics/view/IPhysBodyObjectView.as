/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.view
{
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	import starling.display.DisplayObject;

	public interface IPhysBodyObjectView extends IGOSystemComponent
	{
		function get skin():DisplayObject;
	}
}
