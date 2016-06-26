/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	/**
	 * Mechanism that "spins" all <code>IGearSysGearWheel</code>, that connected to it and calls <code>interact</code> method on each
	 * step (spin).
	 */
	public interface IGearSysMechanism extends IGearSysGearWheelContainer
	{
		/**
		 * Connects <code>IGearSysGearWheel</code> to current <code>IGearSysMechanism</code>.
		 * @param value
		 * @return
		 */
		function addGear(value:IGearSysGearWheel):IGearSysMechanism;

		/**
		 * Disconnects <code>IGearSysGearWheel</code> from current <code>IGearSysMechanism</code>.
		 * @param value
		 * @param dispose Disposes disconnected <code>IGearSysComponent</code>
		 * @return
		 */
		function removeGear(value:IGearSysGearWheel, dispose:Boolean = false):IGearSysMechanism;

		/**
		 * Disconnects all <code>IGearSysGearWheel</code>s from current <code>IGearSysMechanism</code>.
		 * @param dispose Disposes disconnected <code>IGearSysGearWheel</code>s
		 * @return
		 */
		function removeAllGears(dispose:Boolean = false):IGearSysMechanism;

		/**
		 * Returns number of connected <code>IGearSysGearWheel</code>s.
		 */
		function get numGears():int;

		/**
		 * Returns true, if current <code>IGearSysMechanism</code> contains specified <code>IGearSysGearWheel</code>.
		 * @param value
		 * @return
		 */
		function containsGear(value:IGearSysGearWheel):Boolean;

		/**
		 * Returns list, that contains all connected <code>IGearSysGearWheel</code>s to current <code>IGearSysMechanism</code>.
		 */
		function get gearList():Array;
	}
}
