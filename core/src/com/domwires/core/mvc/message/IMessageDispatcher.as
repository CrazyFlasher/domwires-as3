/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.domwires.core.mvc.message
{
	import com.domwires.core.common.Enum;
	import com.domwires.core.common.IDisposable;
	import com.domwires.core.mvc.message.IMessageDispatcherImmutable;

	/**
	 * Common message dispatcher. Can be used for listening and dispatching messages for views and models.
	 * Bubbling feature in any objects (Not only DisplayObjects, like in EventDispatcher).
	 */
	public interface IMessageDispatcher extends IMessageDispatcherImmutable, IDisposable
	{
		/**
		 * Handle specified message without dispatching it.
		 * @param message
		 */
		function handleMessage(message:IMessage):void;
	}
}
