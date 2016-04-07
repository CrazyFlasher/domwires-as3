/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IGOSystem extends IHierarchyObjectContainer, IGearWheel
	{
		function addGameObject(value:IGameObject):IGOSystem;
		function removeGameObject(value:IGameObject, dispose:Boolean = false):IGOSystem;
		function removeAllGameObjects(dispose:Boolean = false):IGOSystem;
		function get numGameObjects():int;
		function containsGameObject(value:IGameObject):Boolean;
		function get gameObjectList():Array;
		function get mechanism():IMechanism;
	}
}
