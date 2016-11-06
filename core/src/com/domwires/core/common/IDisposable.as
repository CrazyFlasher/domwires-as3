/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.domwires.core.common
{
	/**
	 * Any object that need to be disposed to free memory can implement this interface.
	 */
	public interface IDisposable extends IDisposableImmutable
	{
		/**
		 * Removes all references, objects. After that object is ready to be cleaned by GC.
		 */
		function dispose():void;
	}
}
