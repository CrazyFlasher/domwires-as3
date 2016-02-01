package com.crazy.app {
	import flash.display.Sprite;
	import flash.events.UncaughtErrorEvent;

	/**
	 * Main flash application class
	 */
	public class FlashApp extends Sprite implements IApp {

		/**
		 * Constructs new Flash application with standard displayList objects
		 */
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