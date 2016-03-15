/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.JointDataVo;

	import nape.constraint.AngleJoint;
	import nape.constraint.PivotJoint;
	import nape.phys.Body;

	public class JointObject implements IJointObject
	{
		private var _data:JointDataVo;
		private var _joint:AngleJoint;
		
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

		public function get joint():AngleJoint
		{
			return _joint;
		}

		public function connect(body_1:Body, body_2:Body):void
		{
			_joint = new AngleJoint(body_1, body_2, _data.minAngle, _data.maxAngle, 1);
			_joint.ignore = true;
		}
	}
}
