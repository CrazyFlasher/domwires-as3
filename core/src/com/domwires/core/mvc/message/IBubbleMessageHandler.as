/**
 * Created by Anton Nefjodov on 10.06.2016.
 */
package com.domwires.core.mvc.message
{
	public interface IBubbleMessageHandler
	{
		/**
		 * Handler for message bubbling.
		 * It's left to the <code>IBubbleMessageHandler</code> to decide what to do with the message.
		 * @param message The message that bubbled up
		 * @return whether to continue bubbling this message
		 */
		function onMessageBubbled(message:IMessage):Boolean;
	}
}
