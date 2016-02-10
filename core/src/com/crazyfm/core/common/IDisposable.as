/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.common
{
	/**
	 * Any object that need to be disposed to free memory can implement this interface.
	 */
	public interface IDisposable
	{
		/**
		 * Removes all references, objects. After that object is ready to be cleaned by GC.
		 */
		function dispose():void;

		/**
		 * Returns true/false if object has already been disposed.
		 */
		function get isDisposed():Boolean;
	}
}
