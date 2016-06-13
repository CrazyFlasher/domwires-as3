/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IGearSysObject extends IHierarchyObjectContainer, IGearSysGearWheel
	{
		function addComponent(component:IGearSysComponent, priority:int = -1):IGearSysObject;
		function removeComponent(component:IGearSysComponent, dispose:Boolean = false):IGearSysObject;
		function removeAllComponents(dispose:Boolean = false):IGearSysObject;
		function get numComponents():int;
		function containsComponent(component:IGearSysComponent):Boolean;
		function get componentList():Array;
		function getComponentByType(clazz:Class):IGearSysComponent;
		function getComponentsByType(clazz:Class):Array;
		function get goSystem():IGearSys;
	}
}
