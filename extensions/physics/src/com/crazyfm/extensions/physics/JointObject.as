/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.JointDataVo;

	import nape.constraint.AngleJoint;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;

	public class JointObject implements IJointObject
	{
		private var _data:JointDataVo;

		private var _angleJoint:AngleJoint;
		private var _pivotJoint:PivotJoint;

		public function JointObject()
		{
		}

		public function get data():JointDataVo
		{
			return _data;
		}

		public function set data(value:JointDataVo):void
		{
			_data = value;
		}

		public function connect(body_1:Body, body_2:Body):void
		{
			var anchor_1:Vec2 = body_1.worldPointToLocal(new Vec2(_data.x, _data.y), true);
			var anchor_2:Vec2 = body_2.worldPointToLocal(new Vec2(_data.x, _data.y), true);
			_pivotJoint = new PivotJoint(body_1, body_2, anchor_1, anchor_2);
			_pivotJoint.ignore = true;
			//_pivotJoint.stiff = false;

			if (!isNaN(_data.minAngle) && !isNaN(_data.maxAngle))
			{
				_angleJoint = new AngleJoint(body_1, body_2, _data.minAngle, _data.maxAngle, 1);
				_angleJoint.stiff = false;
			}
		}

		public function get pivotJoint():PivotJoint
		{
			return _pivotJoint;
		}

		public function get angleJoint():AngleJoint
		{
			return _angleJoint;
		}
	}
}
