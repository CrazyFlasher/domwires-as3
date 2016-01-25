package com.crazy.app {
	import flash.display3D.Context3DProfile;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.getDefinitionByName;

	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.SystemUtil;

	/**
	 * Anton Nefodov
	 * @author 
	 */
	public class StarlingApp extends FlashApp {
		protected var stageWidth:int  = 1920;
		protected var stageHeight:int = 1080;

		private var fullScreenWidth:int;
		private var fullScreenHeight:int;

		protected var _starlingClass:Class;
		protected var _starling:*;

		private var _iOS:Boolean;
		
		public function StarlingApp() {
			super();
		}

		override public function init(rootClass:Class):void
		{
			super.init(rootClass);

			_starlingClass = getDefinitionByName("starling.core.Starling") as Class;

			_iOS = SystemUtil.platform == "IOS";

			_starlingClass.multitouchEnabled = true; // useful on mobile devices
			_starlingClass.handleLostContext = true; // recommended everywhere when using AssetManager

			var renderTextureClass:Class = getDefinitionByName("starling.textures.RenderTexture") as Class;
			renderTextureClass.optimizePersistentBuffers = _iOS; // safe on iOS, dangerous on Android
		}

		override protected function initRoot():void
		{
			_starling = new _starlingClass(_rootClass, stage, null, null, "auto", Context3DProfile.BASELINE_CONSTRAINED);
			_starling.addEventListener("rootCreated", rootClassInitialized);
			_starling.antiAliasing = 0;

			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.simulateMultitouch = false;
		}

		protected function rootClassInitialized():void {
			_starling.removeEventListener("rootCreated", rootClassInitialized);

			_starling.stage.addEventListener("resize", onStageResize);

			_starling.start();

			if (SystemUtil.platform == "IOS" || SystemUtil.platform == "AND") {
				onStageResize(null, stage.fullScreenWidth, stage.fullScreenHeight);
			}else
			{
				onStageResize(null, stage.stageWidth, stage.stageHeight);
			}
		}

		private function onStageResize(e:* = null, w:int = 0, h:int = 0):void {
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

	}

}