/**
 * Created by Anton Nefjodov on 6.02.2016.
 */
package com.crazyfm.extension.preloader
{
	import com.crazyfm.mvc.event.ISignalEvent;
	import com.crazyfm.mvc.view.ViewController;

	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class PreloaderViewController extends ViewController
	{
		private var _preloader:Sprite;

		public function PreloaderViewController(container:MovieClip)
		{
			super(container);

			init();
		}

		private function init():void
		{
			addSignalListener(PreloaderSignalEnum.PROGRESS, preloaderProgress);
		}

		private function preloaderProgress(event:ISignalEvent):void
		{
			var data:LoadingProgressVo = event.data as LoadingProgressVo;
			reDrawPreloader(data.bytesLoaded, data.bytesTotal);
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
				_container.addChild(_preloader);
			}

			_preloader.graphics.clear();
			_preloader.graphics.beginFill(0xFFFE6E);
			_preloader.graphics.drawRect(200, (_container.stage.stageHeight - 10) / 2,
										 (_container.stage.stageWidth - 400) * bytesLoaded / bytesTotal, 10);
			_preloader.graphics.endFill();
		}

		override public function dispose():void
		{
			if(_preloader)
			{
				_container.removeChild(_preloader);
				_preloader = null;
			}

			super.dispose();
		}
	}
}
