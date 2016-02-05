/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.app
{
	import com.crazyfm.common.IDisposable;

	import flash.events.UncaughtErrorEvent;

	/**
	 * Main application interface.
	 */
	public interface IApp extends IDisposable
	{
		/**
		 * Called, when uncaught error occurs.
		 * @param event
		 */
		function handleUncaughtError(event:UncaughtErrorEvent):void;

		/**
		 * Returns true if app is initialized.
		 */
		function get isInitialized():Boolean;
	}
}
