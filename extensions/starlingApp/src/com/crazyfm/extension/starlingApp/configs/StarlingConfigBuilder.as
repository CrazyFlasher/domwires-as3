/**
 * Created by CrazyFlasher on 31.08.2016.
 */
package com.crazyfm.extension.starlingApp.configs
{
	import flash.display3D.Context3DProfile;

	import starling.utils.ScaleMode;

	public class StarlingConfigBuilder
	{
		/**
		 * Starling stage width.
		 */
		public var stageWidth:int  = 800;

		/**
		 * Starling stage height.
		 */
		public var stageHeight:int = 600;

		/**
		 * Provides constant values for the 'RectangleUtil.fit' method.
		 */
		public var scaleMode:String = ScaleMode.NONE;

		/**
		 * The Context3D render mode that should be requested. Use this parameter if you want to force "software" rendering.
		 */
		public var renderMode:String = "auto";

		/**
		 * The antialiasing level. 0 - no antialiasing, 16 - maximum antialiasing.
		 */
		public var antiAliasing:int = 0;

		/**
		 * The Context3D profile that should be requested.
		 */
		public var context3DProfile:String = Context3DProfile.BASELINE_CONSTRAINED;

		/**
		 * Use pixel perfect on iOS when scaling.
		 */
		public var pixelPerfectOnIOS:Boolean = true;

		/**
		 * If true, then <code>ResizeEvent.RESIZE</code> affects scale of <code>Starling</code> stage,
		 * else scale of root <code>DisplayObjectContainer</code>
		 */
		public var resizeRoot:Boolean = false;

		public function build():StarlingConfig
		{
			var config:StarlingConfig = new StarlingConfig();
			config._stageWidth = stageWidth;
			config._stageHeight = stageHeight;
			config._scaleMode = scaleMode;
			config._renderMode = renderMode;
			config._antiAliasing = antiAliasing;
			config._context3DProfile = context3DProfile;
			config._pixelPerfectOnIOS = pixelPerfectOnIOS;
			config._resizeRoot = resizeRoot;

			return config;
		}
	}
}
