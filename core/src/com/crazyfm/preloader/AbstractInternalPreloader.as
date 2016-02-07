/**
 * Created by Anton Nefjodov
 */
package com.crazyfm.preloader {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.UncaughtErrorEvent;

    /**
     * Application internal preloader. Application should be built with additional compiler option:
     * "-frame=two,my.cool.package.MyMain
     * After app is completely downloaded, preloader will move to second frame.
     * Before that, use as less classes as possible, so preloader will be shown faster.
     */
    public class AbstractInternalPreloader extends MovieClip
    {
        private var _preloader:Sprite;

        public function AbstractInternalPreloader() {
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
            stop();

            loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
            loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
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
         * Override this method and add initialize implementation here.
         */
        protected function appLoaded():void {
            throw new Error("AbstractInternalPreloader#appLoaded: method MUST be overriden!");
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
    }
}
