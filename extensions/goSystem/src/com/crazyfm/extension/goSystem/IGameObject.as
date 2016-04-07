/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IGameObject extends IHierarchyObjectContainer, IGearWheel
	{
		function setEnabled(value:Boolean):IGameObject;
		function get isEnabled():Boolean;
		function addComponent(component:IGameComponent):IGameObject;
		function removeComponent(component:IGameComponent, dispose:Boolean = false):IGameObject;
		function removeAllComponents(dispose:Boolean = false):IGameObject;
		function get numComponents():int;
		function containsComponent(component:IGameComponent):Boolean;
		function get componentList():Array;
		function getComponentByType(clazz:Class):IGameComponent;
		function getComponentsByType(clazz:Class):Vector.<IGameComponent>;
		function get goSystem():IGOSystem;
	}
}
