package com.crazy.app {
	import flash.display.Sprite;
	import flash.events.UncaughtErrorEvent;

	/**
	 * Main flash application class.
	 */
	public class FlashApp extends Sprite implements IApp {

		private var _isInitialized:Boolean;

		/**
		 * Constructs new Flash application with standard displayList objects.
		 */
		public function FlashApp() {
			super();

			appInitialized();
		}

		/**
		 * Override to make any further actions, when app object is initialized and ready to continue lifecycle.
		 */
		protected function appInitialized():void
		{

		}

		/**
		 * @inheritDoc
		 */
		public function handleUncaughtError(event:UncaughtErrorEvent):void
		{

		}

		/**
		 * @inheritDoc
		 */
		public function get isInitialized():Boolean
		{
			return _isInitialized;
		}
	}

}