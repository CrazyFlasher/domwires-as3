package com.crazyfm.app {
	import flash.display.Sprite;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
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
	 * Main starling application class.
	 */
	public class StarlingApp extends Sprite implements IApp {
		protected var stageWidth:int  = 1920;
		protected var stageHeight:int = 1080;

		private var fullScreenWidth:int;
		private var fullScreenHeight:int;

		protected var _starling:Starling;

		private var _iOS:Boolean;
		private var _rootClass:Class;
		private var _isInitialized:Boolean;

		/**
		 * Constructs new Starling application object.
		 * @param rootClass Type of main view class, that should extend starling.display.DisplayObjectContainer
		 */
		public function StarlingApp(rootClass:Class) {
			super();

			_rootClass = rootClass;

			if(!stage)
			{
				addEventListener(flash.events.Event.ADDED_TO_STAGE, added);
			}else
			{
				init();
			}
		}

		private function added(event:flash.events.Event):void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, added);

			init();
		}

		private function init():void
		{
			_iOS = SystemUtil.platform == "IOS";

			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // recommended everywhere when using AssetManager

			RenderTexture.optimizePersistentBuffers = _iOS; // safe on iOS, dangerous on Android

			_starling = new Starling(_rootClass, stage, null, null, "auto", Context3DProfile.BASELINE_CONSTRAINED);
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, rootClassInitialized);
			_starling.antiAliasing = 0;

			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.simulateMultitouch = false;
		}

		private function rootClassInitialized():void {
			_starling.removeEventListener(starling.events.Event.ROOT_CREATED, rootClassInitialized);

			_starling.stage.addEventListener(ResizeEvent.RESIZE, onStageResize);

			_starling.start();

			if (SystemUtil.platform == "IOS" || SystemUtil.platform == "AND") {
				onStageResize(null, stage.fullScreenWidth, stage.fullScreenHeight);
			}else
			{
				onStageResize(null, stage.stageWidth, stage.stageHeight);
			}

			appInitialized();
		}

		/**
		 * Override to make any further actions, when app object is initialized and ready to continue lifecycle.
		 */
		protected function appInitialized():void
		{

		}

		private function onStageResize(e:ResizeEvent = null, w:int = 0, h:int = 0):void {
			var width:int = e == null ? w : e.width;
			var height:int = e == null ? h : e.height;

			_starling.stage.stageWidth = stageWidth;  // <- same size on all devices!
			_starling.stage.stageHeight = stageHeight; // <- same size on all devices!

			fullScreenWidth = width;
			fullScreenHeight = height;

			var stageSize:Rectangle  = new Rectangle(0, 0, stageWidth, stageHeight);
			var screenSize:Rectangle = new Rectangle(0, 0, fullScreenWidth, fullScreenHeight);
			var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL, _iOS);

			_starling.viewPort = viewPort;
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