/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.app
{
	import flash.events.UncaughtErrorEvent;

	/**
	 * Main application interface
	 */
	public interface IApp
	{
		/**
		 * Called, when uncaught error occurs
		 * @param event
		 */
		function handleUncaughtError(event:UncaughtErrorEvent):void;
	}
}
