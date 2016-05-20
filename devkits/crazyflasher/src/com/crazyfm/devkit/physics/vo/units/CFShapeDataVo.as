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

		public function CFShapeDataVo(json:Object)
		{
			super(json);

			_isLadder = json.customData.isLadder;
			_teleportExitId = json.customData.teleportExitId;
		}

		public function get isLadder():Boolean
		{
			return _isLadder;
		}

		public function get teleportExitId():String
		{
			return _teleportExitId;
		}
	}
}
