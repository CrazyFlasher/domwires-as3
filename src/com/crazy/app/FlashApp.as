package com.crazy.app {
	import com.crazy.app.api.IApp;

	import flash.display.Sprite;
	import flash.events.UncaughtErrorEvent;

	/**
	 * Anton Nefjodov
	 * @author 
	 */
	public class FlashApp extends Sprite implements IApp {

		public function FlashApp() {
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function handleUncaughtError(event:UncaughtErrorEvent):void
		{

		}
	}

}