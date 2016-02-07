/**
 * Created by Anton Nefjodov on 6.02.2016.
 */
package com.crazyfm.extension.preloader
{
	import com.crazyfm.mvc.model.Context;

	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.UncaughtErrorEvent;

	/**
	 * Application internal preloader. Application should be built with additional compiler option:
	 * "-frame=two,my.cool.package.MyMain".
	 * After app is completely downloaded, preloader will move to second frame.
	 * Before that, use as less classes as possible, so preloader will be shown faster.
	 *
	 * Dispatches ISignalEvent:
	 * type: PreloaderSignalEnum.PROGRESS, data: LoadingProgressVo
	 * type: PreloaderSignalEnum.UNCAUGHT_ERROR, data: UncaughtErrorEvent#error
	 * type: PreloaderSignalEnum.COMPLETE
	 *
	 * Dispatches flash.display.Event:
	 * type: Event.COMPLETE
	 */
	public class InternalPreloaderContext extends Context implements IPreloaderContext
	{
		private var _loaderInfo:LoaderInfo;
		private var _loadingProgressData:LoadingProgressVo;

		public function InternalPreloaderContext()
		{
			super();
		}

		private function init():void {
			_loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);
		}

		public function set loaderInfo(value:LoaderInfo):void
		{
			if (isDisposed) throw new Error("Object is disposed!");

			if (_loaderInfo) throw new Error("LoaderInfo already assigned!");

			_loaderInfo = value;

			init();
		}

		public function addNativeEventListener(type:String, listener:Function):void
		{
			if (isDisposed) throw new Error("Object is disposed!");
		}

		override public function dispose():void
		{
			if (isDisposed) throw new Error("Object is disposed!");

			_loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_loaderInfo.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);

			_loaderInfo = null;
			_loadingProgressData = null;

			super.dispose();
		}

		private function uncaughtError(event:UncaughtErrorEvent):void {
			dispatchSignal(PreloaderSignalEnum.UNCAUGHT_ERROR, event.error);
		}

		private function progressHandler(event:ProgressEvent):void {
			if (!_loadingProgressData)
			{
				_loadingProgressData = new LoadingProgressVo();
			}
			_loadingProgressData.bytesLoaded = event.bytesLoaded;
			_loadingProgressData.bytesTotal = event.bytesTotal;

			dispatchSignal(PreloaderSignalEnum.PROGRESS, _loadingProgressData);
		}

		private function completeHandler(event:Event):void {
			dispatchSignal(PreloaderSignalEnum.COMPLETE);
		}
	}
}
