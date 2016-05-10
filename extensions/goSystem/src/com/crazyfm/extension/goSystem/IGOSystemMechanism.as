/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IGOSystemMechanism extends IHierarchyObjectContainer
	{
		function addGear(value:IGOSystemGearWheel):IGOSystemMechanism;
		function removeGear(value:IGOSystemGearWheel, dispose:Boolean = false):IGOSystemMechanism;
		function removeAllGears(dispose:Boolean = false):IGOSystemMechanism;
		function get numGears():int;
		function containsGear(value:IGOSystemGearWheel):Boolean;
		function get gearList():Array;
		function interact(passedTime:Number):void;
	}
}
