/**
 * Created by Anton Nefjodov on 28.01.2016.
 */
package com.crazy.mvc.api
{
	import org.osflash.signals.events.IEvent;

	public interface ISignalEvent extends IEvent
	{
		function set data(value:Object):void;
		function get data():Object;
		function set type(value:String):void;
		function get type():String;
	}
}
