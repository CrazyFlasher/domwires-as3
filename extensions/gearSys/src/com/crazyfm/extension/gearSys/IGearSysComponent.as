/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	/**
	 * Default implementation.
	 */
	GearSysComponent;

	/**
	 * Common <code>IGearSysObject</code> child unit. If connected to <code>IGearSysObject</code>, then will be "spinned" together with it
	 * and all other parts of <code>IGearSysObject</code>.
	 */
	public interface IGearSysComponent extends IGearSysGearWheel
	{
		/**
		 * Returns parent <code>IGearSysObject</code>.
		 */
		function get gameObject():IGearSysObject;
	}
}
