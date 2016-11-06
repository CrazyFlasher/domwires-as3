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
	}
}
