/**
 * Created by Anton Nefjodov on 5.02.2016.
 */
package com.crazyfm.extension.starlingApp.app
{
	import flash.display3D.Context3DProfile;

	import starling.utils.ScaleMode;

	public class StarlingProperties
	{
		public var stageWidth:int  = 1920;
		public var stageHeight:int = 1080;
		public var scaleMode:String = ScaleMode.SHOW_ALL;
		public var renderMode:String = "auto";
		public var context3DProfile:String = Context3DProfile.BASELINE_CONSTRAINED;

		public function StarlingProperties()
		{
		}
	}
}
