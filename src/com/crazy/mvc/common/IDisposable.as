/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.common
{
	/**
	 * Any object that need to be disposed to free memory can implement this interface.
	 */
	public interface IDisposable
	{
		/**
		 * Removes all references, object. After that object is ready to be clean by GC.
		 */
		function dispose():void;

		/**
		 * Returns true/false if object has already been disposed.
		 */
		function get isDisposed():Boolean;
	}
}
