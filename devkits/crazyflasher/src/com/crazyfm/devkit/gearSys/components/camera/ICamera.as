/**
 * Created by Anton Nefjodov on 4.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.camera
{
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	import flash.geom.Rectangle;

	import starling.display.DisplayObject;

	Camera;
	public interface ICamera extends IGearSysComponent
	{
		function setFocusObject(value:DisplayObject):ICamera;
		function setViewport(value:Rectangle):ICamera;
		function setAimPosition(x:Number, y:Number):ICamera;
		function updateViewContainerBounds():ICamera;
	}
}
