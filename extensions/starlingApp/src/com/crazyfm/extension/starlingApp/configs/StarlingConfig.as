/**
 * Created by Anton Nefjodov on 5.02.2016.
 */
package com.crazyfm.extension.starlingApp.configs
{
	import flash.display3D.Context3DProfile;

	import starling.utils.ScaleMode;

	/**
	 * Configuration object, that is used for new Starling instance creation.
	 */
	public class StarlingConfig
	{
		internal var _stageWidth:int  = 800;
		internal var _stageHeight:int = 600;
		internal var _scaleMode:String = ScaleMode.NONE;
		internal var _renderMode:String = "auto";
		internal var _antiAliasing:int = 0;
		internal var _context3DProfile:String = Context3DProfile.BASELINE_CONSTRAINED;
		internal var _pixelPerfectOnIOS:Boolean = true;
		internal var _resizeRoot:Boolean = false;
		internal var _skipUnchangedFrames:Boolean = true;

		/**
		 * When enabled, Starling will skip rendering the stage if it hasn't changed since the last frame. This is great for apps that remain static from time to time, since it will greatly reduce power consumption. You should activate this whenever possible!
		 */
		public function get skipUnchangedFrames():Boolean
		{
			return _skipUnchangedFrames;
		}

		/**
		 * Starling stage width.
		 */
		public function get stageWidth():int
		{
			return _stageWidth;
		}

		/**
		 * Starling stage height.
		 */
		public function get stageHeight():int
		{
			return _stageHeight;
		}

		/**
		 * Provides constant values for the 'RectangleUtil.fit' method.
		 */
		public function get scaleMode():String
		{
			return _scaleMode;
		}

		/**
		 * The Context3D render mode that should be requested. Use this parameter if you want to force "software" rendering.
		 */
		public function get renderMode():String
		{
			return _renderMode;
		}

		/**
		 * The antialiasing level. 0 - no antialiasing, 16 - maximum antialiasing.
		 */
		public function get antiAliasing():int
		{
			return _antiAliasing;
		}

		/**
		 * The Context3D profile that should be requested.
		 */
		public function get context3DProfile():String
		{
			return _context3DProfile;
		}

		/**
		 * Use pixel perfect on iOS when scaling.
		 */
		public function get pixelPerfectOnIOS():Boolean
		{
			return _pixelPerfectOnIOS;
		}

		/**
		 * If true, then <code>ResizeEvent.RESIZE</code> affects scale of <code>Starling</code> stage,
		 * else scale of root <code>DisplayObjectContainer</code>
		 */
		public function get resizeRoot():Boolean
		{
			return _resizeRoot;
		}
	}
}
