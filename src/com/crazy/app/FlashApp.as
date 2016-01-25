package com.crazy.app {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.UncaughtErrorEvent;

/**
	 * Anton Nefjodov
	 * @author 
	 */
	public class FlashApp extends MovieClip{

		protected var _preloader:Sprite;

		protected var _rootClass:Class;

		public function FlashApp() {
			super();
		}

		public function init(rootClass:Class):void {
			_rootClass = rootClass;

			this.stop();

			_preloader = new Sprite();
			addChild(_preloader);

			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);

			initUncaughtErrorHandler();
		}

		protected function loaderInfo_progressHandler(event:ProgressEvent):void {
			_preloader.graphics.clear();
			_preloader.graphics.beginFill(0xFFFE6E);
			_preloader.graphics.drawRect(200, (this.stage.stageHeight - 10) / 2,
					(_preloader.stage.stageWidth - 400) * event.bytesLoaded / event.bytesTotal, 10);
			_preloader.graphics.endFill();
		}

		protected function loaderInfo_completeHandler(event:ProgressEvent):void {
			removeNativePreloader();

			this.gotoAndStop(2);

			initRoot();
		}

		protected function initRoot():void {
			addChild(new _rootClass());
		}

		protected function removeNativePreloader():void {
			removeChild(_preloader);
			_preloader = null;
		}

		protected function initUncaughtErrorHandler():void {
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);
		}

		protected function uncaughtError(event:UncaughtErrorEvent):void {

		}
		
	}

}