/**
 * Created by Anton Nefjodov on 4.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.camera
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	import flash.geom.Rectangle;

	import starling.display.DisplayObject;

	public interface ICamera extends IGameComponent
	{
		function setFocusObject(value:DisplayObject):ICamera;
		function setViewport(value:Rectangle):ICamera;
	}
}
