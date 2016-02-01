/**
 * Created by Anton Nefjodov
 */
package com.crazy.preloader {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.UncaughtErrorEvent;

    /**
     * Application internal preloader. Application should be built with additional compiler option:
     * "-frame=two,*document class with package*".
     * After app is completely downloaded, preloader will move to second frame.
     * Before that, use as less classes as possible, so preloader will be shown to user faster.
     */
    public class AbstractPreloader extends MovieClip
    {
        private var _preloader:Sprite;

        public function AbstractPreloader() {
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
		 * Default preloader added to displayList and ready to process preloader actions.
         * Override with super, if you want to add additional logic
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
            removePreloader();

            this.gotoAndStop(2);

            appLoaded();
        }

		/**
         * After that you may initialize all needed objects, classes.
         * Override this method to continue your app initialization
         */
        protected function appLoaded():void {

        }

		/**
		 * Redraws native displayList preloader.
         * Override, if you wan't to use other way to display preloader
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
		 * Removes native displayList preloader.
         * Override, if you are using your own way to draw preloader
         */
        protected function removePreloader():void {
            if(_preloader)
            {
                removeChild(_preloader);
                _preloader = null;
            }
        }

		/**
		 * Initialized global app error catcher
         */
        private function initUncaughtErrorHandler():void {
            loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);
        }

		/**
         * Override to log errors somewhere
         * @param event
         */
        protected function uncaughtError(event:UncaughtErrorEvent):void {

        }
    }
}
