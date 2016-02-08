/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc.event
{
	import com.crazyfm.core.common.IDisposable;

	/**
	 * Common signal dispatcher. Can be used for listening and dispatching signals for views and models.
	 */
	public interface ISignalDispatcher extends IDisposable
	{
		/**
		 * Add signal listener to specified object. Listens bubbled events also.
		 * @param type Signal type/name/id
		 * @param listener Function that will be called when signal received
		 */
		function addSignalListener(type:String, listener:Function):void;

		/**
		 * Removes signal listener from object. Bubbled signals will be also ignored.
		 * @param type Signal type/name/id
		 */
		function removeSignalListener(type:String):void;

		/**
		 * Removes all signal listeners from object. Bubbled signals will be also ignored.
		 */
		function removeAllSignals():void;

		/**
		 * Dispatches signal from bottom to top of the hierarchy.
		 * @param type Signal type/name/id
		 * @param data Optional data that will sent with signal
		 */
		function dispatchSignal(type:String, data:Object = null):void;

		/**
		 * Returns true if object listens for specific signal. Otherwise returns false.
		 * @param type  Signal type/name/id
		 * @return
		 */
		function hasSignalListener(type:String):Boolean;
	}
}
