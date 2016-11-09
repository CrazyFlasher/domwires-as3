/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.domwires.core.mvc.command
{
	import com.domwires.core.common.Enum;
	import com.domwires.core.common.IDisposable;
	import com.domwires.core.mvc.message.IMessage;

	//TODO: execution guards?

	/**
	 * Maps specific messages to <code>ICommand</code>.
	 */
	CommandMapper;
	public interface ICommandMapper extends ICommandMapperImmutable, IDisposable
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
