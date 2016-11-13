/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.domwires.core.mvc.command
{
	import com.domwires.core.common.Enum;
	import com.domwires.core.common.IDisposable;
	import com.domwires.core.mvc.message.IMessage;

	//TODO: execution guards?

	CommandMapper;

	/**
	 * Maps specific messages to <code>ICommand</code>.
	 */
	public interface ICommandMapper extends ICommandMapperImmutable, IDisposable
	{
		/**
		 * Maps message to command. When message occurred, specified command will be implemented.
		 * @param messageType
		 * @param commandClass
		 * @param data Plain data object, which properties will be injected into <code>ICommand</code>.
		 * 			   If command executed via message, and message contains data object, data specified in map method will be
		 *			   overridden by <code>IMessage</code> data
		 * @param once Messaged will be automatically unmapped, after command execution
		 * @return
		 */
		function map(messageType:Enum, commandClass:Class, data:Object = null, once:Boolean = false):ICommandMapper;

		/**
		 * @see #map
		 */
		function map1(messageType:Enum, commandClassList:Vector.<Class>, data:Object = null, once:Boolean = false):ICommandMapper;

		/**
		 * @see #map
		 */
		function map2(messageTypeList:Vector.<Enum>, commandClass:Class, data:Object = null, once:Boolean = false):ICommandMapper;

		/**
		 * @see #map
		 */
		function map3(messageTypeList:Vector.<Enum>, commandClassList:Vector.<Class>, data:Object = null, once:Boolean = false):ICommandMapper;

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
		 * @param data Plain data object, which properties will be injected into <code>ICommand</code>
		 */
		function executeCommand(commandClass:Class, data:Object = null):void;
	}
}
