/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	public interface IGOSystem extends IGOSystemGearWheelContainer
	{
		function addGameObject(value:IGOSystemObject):IGOSystem;
		function removeGameObject(value:IGOSystemObject, dispose:Boolean = false):IGOSystem;
		function removeAllGameObjects(dispose:Boolean = false):IGOSystem;
		function get numGameObjects():int;
		function containsGameObject(value:IGOSystemObject):Boolean;
		function get gameObjectList():Array;
		function get mechanism():IGOSystemMechanism;
		function updateNow():IGOSystem;
	}
}
