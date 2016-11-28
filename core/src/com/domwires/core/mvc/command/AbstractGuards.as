/**
 * Created by CrazyFlasher on 28.11.2016.
 */
package com.domwires.core.mvc.command
{
	/**
	 * @see com.domwires.core.mvc.command.IGuards
	 */
	public class AbstractGuards implements IGuards
	{
		/**
		 * @inheritDoc
		 */
		public function get allows():Boolean
		{
			return false;
		}
	}
}
