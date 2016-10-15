/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.message.IMessage;

	//TODO: execution guards 

	/**
	 * Maps specific messages to <code>ICommand</code>.
	 */
	public interface ICommandMapper
	{
		/**
		 * Maps message to command. When message occurred, specified command will be implemented.
		 * @param messageType
		 * @param commandClass
		 * @return
		 */
		function map(messageType:Enum, commandClass:Class):ICommandMapper;

		/**
		 * Unmaps message from command.
		 * @param messageType
		 * @param commandClass
		 * @return
		 */
		function unmap(messageType:Enum, commandClass:Class):ICommandMapper;

		/**
		 * Clears all mappings.
		 * @return
		 */
		function clear():ICommandMapper;

		/**
		 * Unmaps all commands from specified message.
		 * @param messageType
		 * @return
		 */
		function unmapAll(messageType:Enum):ICommandMapper;

		/**
		 * Returns true, if there are mapping of command to current message.
		 * @param messageType
		 * @return
		 */
		function hasMapping(messageType:Enum):Boolean;

		/**
		 * Trying to find and execute commands, mapped to current message type.
		 * @param message
		 */
		function tryToExecuteCommand(message:IMessage):void;

		/**
		 * Execute command manually.
		 * @param commandClass
		 * @param data plain data object, which properties will be injected into <code>ICommand</code>
		 */
		function executeCommand(commandClass:Class, data:Object = null):void;
	}
}
