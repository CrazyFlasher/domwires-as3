/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo.units
{
	import com.crazyfm.extensions.physics.vo.*;

	public class WorldDataVo extends PhysicsUnitDataVo
	{
		private var _gravity:GravityVo = new GravityVo();

		private var _bodyDataList:Vector.<BodyDataVo>;
		private var _jointDataList:Vector.<JointDataVo>;

		public function WorldDataVo()
		{
			super();
		}

		public function get bodyDataList():Vector.<BodyDataVo>
		{
			return _bodyDataList;
		}

		public function set bodyDataList(value:Vector.<BodyDataVo>):void
		{
			_bodyDataList = value;
		}

		public function get gravity():GravityVo
		{
			return _gravity;
		}

		public function set gravity(value:GravityVo):void
		{
			_gravity = value;
		}

		public function get jointDataList():Vector.<JointDataVo>
		{
			return _jointDataList;
		}

		public function set jointDataList(value:Vector.<JointDataVo>):void
		{
			_jointDataList = value;
		}
	}
}
