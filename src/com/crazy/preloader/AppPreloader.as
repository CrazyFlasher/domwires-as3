/**
 * Created by Anton Nefjodov
 */
package com.crazy.preloader {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.UncaughtErrorEvent;

    public class AppPreloader extends MovieClip
    {
        private var _preloader:Sprite;

        public function AppPreloader() {
            super();

            if(!stage)
            {
                addEventListener(Event.ADDED_TO_STAGE, added);
            }else
            {
                init();
            }
        }

        private function added(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, added);

            init();
        }

		/**
		 * preloader added to displayList and ready to process preloader actions
         */
        protected function init():void {
            this.stop();

            this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
            this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);

            initUncaughtErrorHandler();
        }

        private function loaderInfo_progressHandler(event:ProgressEvent):void {
            reDrawPreloader(event.bytesLoaded, event.bytesTotal);
        }

        private function loaderInfo_completeHandler(event:Event):void {
            appLoaded();
        }

		/**
         * after that you may initialize all needed objects, classes
         */
        protected function appLoaded():void {
            removePreloader();

            this.gotoAndStop(2);
        }

		/**
		 * redraws native displayList preloader
         * @param bytesLoaded
         * @param bytesTotal
         */
        protected function reDrawPreloader(bytesLoaded:Number, bytesTotal:Number):void
        {
            if(!_preloader)
            {
                _preloader = new Sprite();
                addChild(_preloader);
            }

            _preloader.graphics.clear();
            _preloader.graphics.beginFill(0xFFFE6E);
            _preloader.graphics.drawRect(200, (this.stage.stageHeight - 10) / 2,
                                         (_preloader.stage.stageWidth - 400) * bytesLoaded / bytesTotal, 10);
            _preloader.graphics.endFill();
        }

		/**
		 * removes native displayList preloader
         */
        protected function removePreloader():void {
            if(_preloader)
            {
                removeChild(_preloader);
                _preloader = null;
            }
        }

		/**
		 * initialized global app error catcher
         */
        protected function initUncaughtErrorHandler():void {
            loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);
        }

		/**
         * override to log errors somewhere
         * @param event
         */
        protected function uncaughtError(event:UncaughtErrorEvent):void {

        }
    }
}
