/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModelContainer;

	import flash.utils.Dictionary;

	public interface IGOSystem extends IModelContainer, IGearWheel
	{
		function addGameObject(value:IGameObject):IGOSystem;
		function removeGameObject(value:IGameObject, dispose:Boolean = false):IGOSystem;
		function removeAllGameObjects(dispose:Boolean = false, withChildren:Boolean = false):IGOSystem;
		function get numGameObjects():int;
		function containsGameObject(value:IGameObject):Boolean;
		function get gameObjectList():Dictionary;
		function setMechanism(mechanism:IMechanism):IGOSystem;
		function get mechanism():IMechanism;
	}
}
