/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.view
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IViewComponent extends IGameComponent
	{
		function setPositions(x:Number, y:Number):IViewComponent;
		function setDegreeRotation(angle:Number):IViewComponent;
		function setRadianRotation(angle:Number):IViewComponent;
		function get x():Number;
		function get y():Number;
		function get radianRotation():Number;
		function get degreeRotation():Number;
	}
}
