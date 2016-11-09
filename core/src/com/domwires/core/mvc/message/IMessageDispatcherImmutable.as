/**
 * Created by CrazyFlasher on 6.11.2016.
 */
package com.domwires.core.mvc.message
{
	import com.domwires.core.common.Enum;
	import com.domwires.core.common.IDisposableImmutable;

	/**
	 * @see com.domwires.core.mvc.message.IMessageDispatcher
	 */
	public interface IMessageDispatcherImmutable extends IDisposableImmutable
	{
		/**
		 * Returns true if object listens for specific message. Otherwise returns false.
		 * @param type  Message type
		 * @return
		 */
		function hasMessageListener(type:Enum):Boolean;

		/**
		 * Add message listener to specified object. Listens bubbled messages also.
		 * @param type Message type
		 * @param listener Function that will be called when message received
		 */
		function addMessageListener(type:Enum, listener:Function):void;

		/**
		 * Removes message listener from object. Bubbled messages will be also ignored.
		 * @param type Message type
		 * @param listener Function that will be called when message received
		 */
		function removeMessageListener(type:Enum, listener:Function):void;

		/**
		 * Removes all message listeners from object. Bubbled messages will be also ignored.
		 */
		function removeAllMessageListeners():void;

		/**
		 * Dispatches message from bottom to top of the hierarchy.
		 * @param type Message type
		 * @param data Optional data that will sent with message
		 * @param bubbles If true, then message will bubble up to hierarchy
		 */
		function dispatchMessage(type:Enum, data:Object = null, bubbles:Boolean = false):void;

		/**
		 * Makes provided object to catch bubbled messages of this instance.
		 * @param object Object, that will catch bubbled messages
		 */
		function addExtraBubbleListenerObject(object:IBubbleMessageHandler):void

		/**
		 * Makes provided object to stop catching bubbled messages of this instance.
		 * @param object Object, that will not catch bubbled messages anymore
		 */
		function removeExtraBubbleListenerObject(object:IBubbleMessageHandler):void
	}
}
