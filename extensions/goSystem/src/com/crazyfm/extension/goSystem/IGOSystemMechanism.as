/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	public interface IGOSystemMechanism extends IGOSystemGearWheelContainer
	{
		function addGear(value:IGOSystemGearWheel):IGOSystemMechanism;
		function removeGear(value:IGOSystemGearWheel, dispose:Boolean = false):IGOSystemMechanism;
		function removeAllGears(dispose:Boolean = false):IGOSystemMechanism;
		function get numGears():int;
		function containsGear(value:IGOSystemGearWheel):Boolean;
		function get gearList():Array;
	}
}
