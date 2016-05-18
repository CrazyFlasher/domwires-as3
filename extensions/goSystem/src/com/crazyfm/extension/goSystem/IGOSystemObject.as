/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IGOSystemObject extends IHierarchyObjectContainer, IGOSystemGearWheel
	{
		function addComponent(component:IGOSystemComponent, priority:int = -1):IGOSystemObject;
		function removeComponent(component:IGOSystemComponent, dispose:Boolean = false):IGOSystemObject;
		function removeAllComponents(dispose:Boolean = false):IGOSystemObject;
		function get numComponents():int;
		function containsComponent(component:IGOSystemComponent):Boolean;
		function get componentList():Array;
		function getComponentByType(clazz:Class):IGOSystemComponent;
		function getComponentsByType(clazz:Class):Array;
		function get goSystem():IGOSystem;
	}
}
