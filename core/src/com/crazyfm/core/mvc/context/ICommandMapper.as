/**
 * Created by Anton Nefjodov on 26.05.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.Enum;

	/**
	 * Maps specific signals to <code>ICommand</code>.
	 */
	public interface ICommandMapper
	{
		/**
		 * Maps signal to command. When signal occurred, specified command will be implemented.
		 * @param signalType
		 * @param commandClass
		 * @return
		 */
		function map(signalType:Enum, commandClass:Class):ICommandMapper;

		/**
		 * Unmaps signal from command.
		 * @param signalType
		 * @param commandClass
		 * @return
		 */
		function unmap(signalType:Enum, commandClass:Class):ICommandMapper;

		/**
		 * Clears all mappings.
		 * @return
		 */
		function clear():ICommandMapper;

		/**
		 * Unmaps all commands from specified signal.
		 * @param signalType
		 * @return
		 */
		function unmapAll(signalType:Enum):ICommandMapper;

		/**
		 * Returns true, if there are mapping of command to current signal.
		 * @param signalType
		 * @return
		 */
		function hasMapping(signalType:Enum):Boolean;

		/**
		 * Trying to find and execute commands, mapped to current signal.
		 * @param signalType
		 */
		function tryToExecuteCommand(signalType:Enum):void;
	}
}
