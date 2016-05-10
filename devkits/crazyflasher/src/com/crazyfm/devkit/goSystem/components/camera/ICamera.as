/**
 * Created by Anton Nefjodov on 4.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.camera
{
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	import flash.geom.Rectangle;

	import starling.display.DisplayObject;

	public interface ICamera extends IGOSystemComponent
	{
		function setFocusObject(value:DisplayObject):ICamera;
		function setViewport(value:Rectangle):ICamera;
	}
}
