/**
 * Created by Anton Nefjodov on 28.01.2016.
 */
package com.crazy.mvc.api
{
	import org.osflash.signals.events.IEvent;

	public interface ISignalEvent extends IEvent
	{
		function get data():Object;
		function get type():String;
	}
}
