package {
	import com.milkmangames.nativeextensions.GAnalytics;
	import com.milkmangames.nativeextensions.GoViral;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.system.Security;
	import flash.utils.getDefinitionByName;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.textures.RenderTexture;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.SystemUtil;
	
	/**
	 * ...
	 * @author Anton Nefjodov
	 */
	[SWF(width = "1920", height = "1080", frameRate = "60", backgroundColor = "#000000")]
	
	public class StartUp extends MovieClip {
		private var StageWidth:int  = 1920;
        private var StageHeight:int = 1080;
		
		private var fullScreenWidth:int;
		private var fullScreenHeight:int;
		
		private var _starling:Starling;
		
		private var iOS:Boolean;
		
		private var preloader:Sprite;
		
		
		public function StartUp():void {
			init();
		}
		
		private function init():void {
			
			this.stop();
			
			preloader = new Sprite();
			addChild(preloader);
			
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
			this.loaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderInfo_completeHandler);
			
			initUncaughtErrorHandler();
			
			if(!SystemUtil.isAIR) {
				Security.allowDomain("*");
			}
		}
		
		private function loaderInfo_progressHandler(event:ProgressEvent):void
		{
			preloader.graphics.clear();
			preloader.graphics.beginFill(0xFFFE6E);
			preloader.graphics.drawRect(200, (this.stage.stageHeight - 10) / 2,
				(preloader.stage.stageWidth - 400) * event.bytesLoaded / event.bytesTotal, 10);
			preloader.graphics.endFill();
		}

		private function loaderInfo_completeHandler(event:flash.events.Event):void
		{
			removeNativePreloader();
			this.gotoAndStop(2);

			iOS = SystemUtil.platform == "IOS";
			
            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // recommended everywhere when using AssetManager
            RenderTexture.optimizePersistentBuffers = iOS; // safe on iOS, dangerous on Android
			
			var RootType:Class = getDefinitionByName("com.sballs.Main") as Class;
			var StarlingType:Class = getDefinitionByName("starling.core.Starling") as Class;
			
			_starling = new StarlingType(RootType, stage, null, null, "auto", Context3DProfile.BASELINE_CONSTRAINED);
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, startGame);
			_starling.antiAliasing = 0;
			
			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.simulateMultitouch = false;
		}
		
		private function startGame():void {
			_starling.stage.addEventListener(ResizeEvent.RESIZE, onStageResize);
			
			_starling.start();
			
			onStageResize(null, stage.stageWidth, stage.stageHeight);
			//_starling.root.addEventListener("removeNativePreloader", removeNativePreloader);
			
			//_starling.showStatsAt("left", "top", 2);
		}
		
		private function removeNativePreloader():void {
			//_starling.root.removeEventListener("removeNativePreloader", removeNativePreloader);
			
			removeChild(preloader);
			preloader = null;
		}
		
		private function onStageResize(e:ResizeEvent = null, w:int = 0, h:int = 0):void {
			//DebugConsole.print("onStageResize:", e.width, e.height, fullScreenWidth, fullScreenHeight, stage.stageWidth);
			var width:int = e == null ? w : e.width;
			var height:int = e == null ? h : e.height;
			
			_starling.stage.stageWidth    = StageWidth;  // <- same size on all devices!
			_starling.stage.stageHeight   = StageHeight; // <- same size on all devices!
			
			fullScreenWidth = width;
			fullScreenHeight = height;
			
            var stageSize:Rectangle  = new Rectangle(0, 0, StageWidth, StageHeight);
            var screenSize:Rectangle = new Rectangle(0, 0, fullScreenWidth, fullScreenHeight);
            var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL, iOS);
			
			_starling.viewPort = viewPort;
		}
		
		private function initUncaughtErrorHandler():void {
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);
		}
		
		private function uncaughtError(e:UncaughtErrorEvent):void {
			loaderInfo.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);
			
			//TODO: log
		}
	}
	
}