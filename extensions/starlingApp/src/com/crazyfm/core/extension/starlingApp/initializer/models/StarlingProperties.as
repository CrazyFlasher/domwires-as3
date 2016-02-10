/**
 * Created by Anton Nefjodov on 5.02.2016.
 */
package com.crazyfm.core.extension.starlingApp.initializer.models
{
	import flash.display3D.Context3DProfile;

	import starling.utils.ScaleMode;

	/**
	 * Configuration object, that is used for new Starling instance creation.
	 */
	public class StarlingProperties
	{
		public var stageWidth:int  = 800;
		public var stageHeight:int = 600;
		public var scaleMode:String = ScaleMode.NONE;
		public var renderMode:String = "auto";
		public var antiAliasing:int = 0;
		public var context3DProfile:String = Context3DProfile.BASELINE_CONSTRAINED;

		public function StarlingProperties()
		{
		}
	}
}
