/**
 * Created by Anton Nefjodov on 17.05.2016.
 */
package com.crazyfm.devkit.physics.vo.units
{
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;

	public class CFShapeDataVo extends ShapeDataVo
	{
		private var _isLadder:Boolean;

		private var _teleportExitId:String;

		public function CFShapeDataVo()
		{
			super();
		}

		public function get isLadder():Boolean
		{
			return _isLadder;
		}

		public function set isLadder(value:Boolean):void
		{
			_isLadder = value;
		}

		public function get teleportExitId():String
		{
			return _teleportExitId;
		}

		public function set teleportExitId(value:String):void
		{
			_teleportExitId = value;
		}
	}
}
