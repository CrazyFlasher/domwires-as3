/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObject;

	internal interface IGearSysGearWheel extends IHierarchyObject
	{
		/**
		 * Called by external stuff (e.g. some mechanism) and passes time, that should be considered as delay after previous time
		 * interact was called.
		 * @param timePassed
		 */
		function interact(timePassed:Number):void;

		/**
		 * Enables of disables current <code>IGearSysGearWheel</code>.
		 * @param value
		 * @return
		 */
		function setEnabled(value:Boolean):IGearSysGearWheel;

		/**
		 * Returns true, if <code>IGearSysGearWheel</code> is enabled.
		 */
		function get isEnabled():Boolean;

		//TODO
//		function interactStarted():void;
	}
}
