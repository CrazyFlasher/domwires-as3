/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.core.extension.starlingApp.initializer.models
{
	import com.crazyfm.core.extension.starlingApp.initializer.signals.StarlingInitializerSignal;
	import com.crazyfm.core.mvc.model.Context;

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

	//TODO: ASDoc
	/**
	 * StarlingInitializerSignal.STARLING_INITIALIZED
	 */
	public class StarlingInitializerContext extends Context
	{
		private var _starling:Starling;

		private var _iOS:Boolean;
		private var _rootClass:Class;

		private var _properties:StarlingProperties;
		private var _stage:Stage;

		public function StarlingInitializerContext(stage:Stage, rootClass:Class, properties:StarlingProperties = null)
		{
			super();

			_stage = stage;
			_rootClass = rootClass;

			if (!properties)
			{
				_properties = new StarlingProperties();
			}else
			{
				_properties = properties;
			}

			init();
		}

		private function init():void
		{
			_iOS = SystemUtil.platform == "IOS";

			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // recommended everywhere when using AssetManager

			RenderTexture.optimizePersistentBuffers = _iOS; // safe on iOS, dangerous on Android

			_starling = new Starling(_rootClass, _stage, null, null, _properties.renderMode, _properties.context3DProfile);
			_starling.addEventListener(Event.ROOT_CREATED, rootClassInitialized);
			_starling.antiAliasing = _properties.antiAliasing;

			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.simulateMultitouch = false;
		}

		private function rootClassInitialized():void {
			_starling.removeEventListener(Event.ROOT_CREATED, rootClassInitialized);

			_starling.start();


			if (_properties.scaleMode != ScaleMode.NONE)
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
			dispatchSignal(StarlingInitializerSignal.STARLING_INITIALIZED);
		}

		private function onStageResize(e:ResizeEvent = null, w:int = 0, h:int = 0):void {
			var width:int = e == null ? w : e.width;
			var height:int = e == null ? h : e.height;

			_starling.stage.stageWidth = _properties.stageWidth;  // <- same size on all devices!
			_starling.stage.stageHeight = _properties.stageHeight; // <- same size on all devices!

			var fullScreenWidth:int = width;
			var fullScreenHeight:int = height;

			var stageSize:Rectangle  = new Rectangle(0, 0, _properties.stageWidth, _properties.stageHeight);
			var screenSize:Rectangle = new Rectangle(0, 0, fullScreenWidth, fullScreenHeight);
			var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, _properties.scaleMode, _iOS);

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

			_properties = null;
			_stage = null;

			super.dispose();
		}
	}
}
