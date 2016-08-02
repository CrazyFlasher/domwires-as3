/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	/**
	 * Default implementation.
	 */
	GearSys;

	[Event(name="INITIALIZED", type="com.crazyfm.extension.gearSys.messages.GearSysMessageEnum")]
	[Event(name="STEP", type="com.crazyfm.extension.gearSys.messages.GearSysMessageEnum")]

	/**
	 * <code>IGearSys</code> is a main object of pattern (especially for games), that makes your application logic to be similar to constructor.
	 * <code>IGearSysMechanism</code> forces <code>IGearSys</code> to "spin". <code>IGearSys</code> can have as many <code>IGearSysObjects</code>
	 * as needed, which will be "spinned" by <code>IGearSys</code>. Each <code>IGearSysObject</code> can have several (unlimited)
	 * <code>IGearSysComponents</code>, which will be "spinned" by parent <code>IGearSysObject</code>.
	 */
	public interface IGearSys extends IGearSysGearWheelContainer
	{
		/**
		 * Connects <code>IGearSysObject</code> to current <code>IGearSys</code>.
		 * @param value
		 * @return
		 */
		function addGameObject(value:IGearSysObject):IGearSys;

		/**
		 * Disconnects <code>IGearSysObject</code> from current <code>IGearSys</code>.
		 * @param value
		 * @param dispose Disposes disconnected <code>IGearSysObject</code>
		 * @return
		 */
		function removeGameObject(value:IGearSysObject, dispose:Boolean = false):IGearSys;

		/**
		 * Disconnects all <code>IGearSysObject</code>s from current <code>IGearSys</code>.
		 * @param dispose Disposes disconnected <code>IGearSysObject</code>s
		 * @return
		 */
		function removeAllGameObjects(dispose:Boolean = false):IGearSys;

		/**
		 * Returns number of connected <code>IGearSysObject</code>s.
		 */
		function get numGameObjects():int;

		/**
		 * Returns true, if current <code>IGearSys</code> contains specified <code>IGearSysObject</code>.
		 * @param value
		 * @return
		 */
		function containsGameObject(value:IGearSysObject):Boolean;

		/**
		 * Returns list, that contains all connected <code>IGearSysObject</code>s to current <code>IGearSys</code>.
		 */
		function get gameObjectList():Array;

		/**
		 * Returns <code>IGearSysMechanism</code>, that "spins" current <code>IGearSys</code>.
		 */
		function get mechanism():IGearSysMechanism;

		/**
		 * "Spins" current <code>IGearSys</code> immediately.
		 * @return
		 */
		function updateNow():IGearSys;
	}
}
