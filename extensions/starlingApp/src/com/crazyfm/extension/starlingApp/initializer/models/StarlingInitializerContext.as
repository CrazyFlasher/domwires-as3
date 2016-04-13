/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.extension.starlingApp.initializer.models
{
	import com.crazyfm.core.mvc.context.Context;
	import com.crazyfm.extension.starlingApp.initializer.signals.StarlingInitializerSignalEnum;

	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.textures.RenderTexture;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.SystemUtil;

	/**
	 * Context that configures and launches new Starling instance.
	 * Dispatches signals:
	 * StarlingInitializerSignal.STARLING_INITIALIZED
	 */
	public class StarlingInitializerContext extends Context
	{
		private var _starling:Starling;

		private var _iOS:Boolean;
		private var _rootClass:Class;

		private var _config:StarlingConfig;
		private var _stage:Stage;

		/**
		 * Creates IContext, that configures and launches new Starling instance.
		 * @param stage The Flash (2D) stage.
		 * @param rootClass A subclass of 'starling.display.DisplayObject'. It will be created as soon as initialization is finished and
		 * will become the first child of the Starling stage. Pass null if you don't want to create a root object right away. (You can use the rootClass property later to make that happen).
		 * @param config
		 */
		public function StarlingInitializerContext(stage:Stage, rootClass:Class, config:StarlingConfig = null)
		{
			super();

			_stage = stage;
			_rootClass = rootClass;

			if (!config)
			{
				_config = new StarlingConfig();
			}else
			{
				_config = config;
			}

			init();
		}

		private function init():void
		{
			_iOS = SystemUtil.platform == "IOS";

			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // recommended everywhere when using AssetManager

			RenderTexture.optimizePersistentBuffers = _iOS; // safe on iOS, dangerous on Android

			_starling = new Starling(_rootClass, _stage, null, null, _config.renderMode, _config.context3DProfile);
			_starling.addEventListener(Event.ROOT_CREATED, rootClassInitialized);
			_starling.antiAliasing = _config.antiAliasing;

			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.simulateMultitouch = false;
		}

		private function rootClassInitialized():void {
			_starling.removeEventListener(Event.ROOT_CREATED, rootClassInitialized);

			_starling.start();


			if (_config.scaleMode != ScaleMode.NONE)
			{
				_starling.stage.addEventListener(ResizeEvent.RESIZE, onStageResize);

				if (SystemUtil.platform == "IOS" || SystemUtil.platform == "AND") {
					onStageResize(null, _stage.fullScreenWidth, _stage.fullScreenHeight);
				}else
				{
					onStageResize(null, _stage.stageWidth, _stage.stageHeight);
				}
			}

			appInitialized();
		}

		private function appInitialized():void
		{
			dispatchSignal(StarlingInitializerSignalEnum.STARLING_INITIALIZED);
		}

		private function onStageResize(e:ResizeEvent = null, w:int = 0, h:int = 0):void {
			var width:int = e == null ? w : e.width;
			var height:int = e == null ? h : e.height;

			_starling.stage.stageWidth = _config.stageWidth;  // <- same size on all devices!
			_starling.stage.stageHeight = _config.stageHeight; // <- same size on all devices!

			var fullScreenWidth:int = width;
			var fullScreenHeight:int = height;

			var stageSize:Rectangle  = new Rectangle(0, 0, _config.stageWidth, _config.stageHeight);
			var screenSize:Rectangle = new Rectangle(0, 0, fullScreenWidth, fullScreenHeight);
			var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, _config.scaleMode, _iOS);

			_starling.viewPort = viewPort;
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			if (_starling)
			{
				_starling.stage.removeEventListener(ResizeEvent.RESIZE, onStageResize);
				_starling.dispose();
				_starling = null;
			}

			_config = null;
			_stage = null;
			_rootClass = null;

			super.dispose();
		}

		/**
		 * Returns created Starling instance.
		 */
		public function get starling():Starling
		{
			return _starling;
		}
	}
}
