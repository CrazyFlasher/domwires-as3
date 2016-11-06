/**
 * Created by CrazyFlasher on 6.11.2016.
 */
package com.domwires.core.mvc.command
{
	import com.domwires.core.common.Enum;
	import com.domwires.core.common.IDisposableImmutable;

	/**
	 * @see com.domwires.core.mvc.command.ICommandMapper
	 */
	public interface ICommandMapperImmutable extends IDisposableImmutable
	{
		/**
		 * Returns true, if there are mapping of command to current message.
		 * @param messageType
		 * @return
		 */
		function hasMapping(messageType:Enum):Boolean;
	}
}
