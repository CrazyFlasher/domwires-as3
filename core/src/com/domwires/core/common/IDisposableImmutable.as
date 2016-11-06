/**
 * Created by CrazyFlasher on 6.11.2016.
 */
package com.domwires.core.common
{
	/**
	 * @see com.domwires.core.common.IDisposable
	 */
	public interface IDisposableImmutable
	{
		/**
		 * Returns true/false if object has already been disposed.
		 */
		function get isDisposed():Boolean;
	}
}
