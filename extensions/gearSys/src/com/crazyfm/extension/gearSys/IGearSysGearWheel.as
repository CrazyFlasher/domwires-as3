/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObject;

	public interface IGearSysGearWheel extends IHierarchyObject
	{
		function interact(timePassed:Number):void;
		function setEnabled(value:Boolean):IGearSysGearWheel;
		function get isEnabled():Boolean;

		//TODO
//		function interactStarted():void;
	}
}
