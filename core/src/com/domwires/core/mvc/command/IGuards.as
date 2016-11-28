/**
 * Created by CrazyFlasher on 28.11.2016.
 */
package com.domwires.core.mvc.command
{
	/**
	 * Checks, if command can be executed.
	 */
	public interface IGuards
	{
		/**
		 * Returns true, if all conditions suit, and command can be executed.
		 */
		function get allows():Boolean;
	}
}
