/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.mvc.message
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.common.IDisposable;

	/**
	 * Common message dispatcher. Can be used for listening and dispatching messages for views and models.
	 */
	public interface IMessageDispatcher extends IDisposable
	{
		/**
		 * Add message listener to specified object. Listens bubbled messages also.
		 * @param type Message type
		 * @param listener Function that will be called when message received
		 */
		function addMessageListener(type:Enum, listener:Function):void;

		/**
		 * Removes message listener from object. Bubbled messages will be also ignored.
		 * @param type Message type
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
		function dispatchMessage(type:Enum, data:Object = null, bubbles:Boolean = true):void;

		/**
		 * Returns true if object listens for specific message. Otherwise returns false.
		 * @param type  Message type
		 * @return
		 */
		function hasMessageListener(type:Enum):Boolean;

		/**
		 * Handle specified message without dispatching it.
		 * @param message
		 */
		function handleMessage(message:IMessage):void;
	}
}
