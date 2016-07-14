/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.extension.starlingApp.initializer
{
	import com.crazyfm.core.mvc.message.MessageDispatcher;
	import com.crazyfm.extension.starlingApp.configs.StarlingConfig;
	import com.crazyfm.extension.starlingApp.messages.StarlingInitializerMessage;

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
	 * Object that configures and launches new Starling instance.
	 * Dispatches signals:
	 * StarlingInitializerMessage.STARLING_INITIALIZED
	 */
	public class StarlingInitializer extends MessageDispatcher implements IStarlingInitializer
	{
		[Autowired]
		public var stage:Stage;

		[Autowired]
		public var config:StarlingConfig;

		[Autowired]
		public var rootClass:Class;

		private var _starling:Starling;

		private var _iOS:Boolean;

		public function StarlingInitializer()
		{
			super();
		}

		[PostConstruct]
		public function init():void
		{
			_iOS = SystemUtil.platform == "IOS";

			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // recommended everywhere when using AssetManager

			RenderTexture.optimizePersistentBuffers = _iOS; // safe on iOS, dangerous on Android

			_starling = new Starling(rootClass, stage, null, null, config.renderMode, config.context3DProfile);
			_starling.addEventListener(Event.ROOT_CREATED, rootClassInitialized);
			_starling.antiAliasing = config.antiAliasing;

			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.simulateMultitouch = false;
		}

		private function rootClassInitialized():void {
			_starling.removeEventListener(Event.ROOT_CREATED, rootClassInitialized);

			_starling.start();


			if (config.scaleMode != ScaleMode.NONE)
			{
				_starling.stage.addEventListener(ResizeEvent.RESIZE, onStageResize);

				if (SystemUtil.platform == "IOS" || SystemUtil.platform == "AND") {
					onStageResize(null, stage.fullScreenWidth, stage.fullScreenHeight);
				}else
				{
					onStageResize(null, stage.stageWidth, stage.stageHeight);
				}
			}

			appInitialized();
		}

		private function appInitialized():void
		{
			dispatchMessage(StarlingInitializerMessage.STARLING_INITIALIZED);
		}

		private function onStageResize(e:ResizeEvent = null, w:int = 0, h:int = 0):void {
			var width:int = e == null ? w : e.width;
			var height:int = e == null ? h : e.height;

			_starling.stage.stageWidth = config.stageWidth;  // <- same size on all devices!
			_starling.stage.stageHeight = config.stageHeight; // <- same size on all devices!

			var fullScreenWidth:int = width;
			var fullScreenHeight:int = height;

			var stageSize:Rectangle  = new Rectangle(0, 0, config.stageWidth, config.stageHeight);
			var screenSize:Rectangle = new Rectangle(0, 0, fullScreenWidth, fullScreenHeight);
			var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, config.scaleMode, _iOS && config.pixelPerfectOnIOS);

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

			config = null;
			stage = null;
			rootClass = null;

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function get starling():Starling
		{
			return _starling;
		}
	}
}
