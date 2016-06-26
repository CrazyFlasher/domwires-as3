/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	/**
	 * Default implementation.
	 */
	GearSysObject;

	/**
	 * Common <code>IGearSys</code> child unit. If connected to <code>IGearSys</code>, then will be "spinned" together with it and all other
	 * parts of <code>IGearSys</code>.
	 */
	public interface IGearSysObject extends IHierarchyObjectContainer, IGearSysGearWheel
	{
		/**
		 * /**
		 * Connects <code>IGearSysComponent</code> to current <code>IGearSysObject</code>.
		 * @param component
		 * @param priority Which in order component will be "spinned"
		 * @return
		 */
		function addComponent(component:IGearSysComponent, priority:int = -1):IGearSysObject;

		/**
		 * Disconnects <code>IGearSysComponent</code> from current <code>IGearSysObject</code>.
		 * @param component
		 * @param dispose Disposes disconnected <code>IGearSysComponent</code>
		 * @return
		 */
		function removeComponent(component:IGearSysComponent, dispose:Boolean = false):IGearSysObject;

		/**
		 * Disconnects all <code>IGearSysComponent</code>s from current <code>IGearSysObject</code>.
		 * @param dispose Disposes disconnected <code>IGearSysComponent</code>s
		 * @return
		 */
		function removeAllComponents(dispose:Boolean = false):IGearSysObject;

		/**
		 * Returns number of connected <code>IGearSysComponent</code>s.
		 */
		function get numComponents():int;

		/**
		 * Returns true, if current <code>IGearSysObject</code> contains specified <code>IGearSysComponent</code>.
		 * @param component
		 * @return
		 */
		function containsComponent(component:IGearSysComponent):Boolean;

		/**
		 * Returns list, that contains all connected <code>IGearSysComponent</code>s to current <code>IGearSysObject</code>.
		 */
		function get componentList():Array;

		/**
		 * Returns connected component by provided type.
		 * @param clazz
		 * @return
		 */
		function getComponentByType(clazz:Class):IGearSysComponent;

		/**
		 * Returns list of connected components by provided type.
		 * @param clazz
		 * @return
		 */
		function getComponentsByType(clazz:Class):Array;

		/**
		 * Returns <code>IGearSys</code>, which current <code>IGearSysObject</code> is connected to.
		 */
		function get gearSys():IGearSys;
	}
}
