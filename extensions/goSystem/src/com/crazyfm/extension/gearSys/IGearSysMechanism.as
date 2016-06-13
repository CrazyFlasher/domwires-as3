/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	public interface IGearSysMechanism extends IGearSysGearWheelContainer
	{
		function addGear(value:IGearSysGearWheel):IGearSysMechanism;
		function removeGear(value:IGearSysGearWheel, dispose:Boolean = false):IGearSysMechanism;
		function removeAllGears(dispose:Boolean = false):IGearSysMechanism;
		function get numGears():int;
		function containsGear(value:IGearSysGearWheel):Boolean;
		function get gearList():Array;
	}
}
