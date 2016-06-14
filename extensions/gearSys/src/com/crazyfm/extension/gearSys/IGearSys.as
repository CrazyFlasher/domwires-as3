/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	public interface IGearSys extends IGearSysGearWheelContainer
	{
		function addGameObject(value:IGearSysObject):IGearSys;
		function removeGameObject(value:IGearSysObject, dispose:Boolean = false):IGearSys;
		function removeAllGameObjects(dispose:Boolean = false):IGearSys;
		function get numGameObjects():int;
		function containsGameObject(value:IGearSysObject):Boolean;
		function get gameObjectList():Array;
		function get mechanism():IGearSysMechanism;
		function updateNow():IGearSys;
	}
}
