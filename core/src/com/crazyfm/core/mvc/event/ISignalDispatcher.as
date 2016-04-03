/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc.event
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.common.IDisposable;

	/**
	 * Common signal dispatcher. Can be used for listening and dispatching signals for views and models.
	 */
	public interface ISignalDispatcher extends IDisposable
	{
		/**
		 * Add signal listener to specified object. Listens bubbled events also.
		 * @param type Signal type
		 * @param listener Function that will be called when signal received
		 */
		function addSignalListener(type:Enum, listener:Function):void;

		/**
		 * Removes signal listener from object. Bubbled signals will be also ignored.
		 * @param type Signal type
		 */
		function removeSignalListener(type:Enum):void;

		/**
		 * Removes all signal listeners from object. Bubbled signals will be also ignored.
		 */
		function removeAllSignalListeners():void;

		/**
		 * Dispatches signal from bottom to top of the hierarchy.
		 * @param type Signal type
		 * @param data Optional data that will sent with signal
		 * @param bubbles If true, then signal will bubble up to hierarchy
		 */
		function dispatchSignal(type:Enum, data:Object = null, bubbles:Boolean = true):void;

		/**
		 * Returns true if object listens for specific signal. Otherwise returns false.
		 * @param type  Signal type
		 * @return
		 */
		function hasSignalListener(type:Enum):Boolean;
	}
}
