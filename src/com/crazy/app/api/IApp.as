/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.app.api
{
	import flash.events.UncaughtErrorEvent;

	public interface IApp
	{
		/**
		 * called, when uncaught error occurs
		 * @param event
		 */
		function handleUncaughtError(event:UncaughtErrorEvent):void;
	}
}
