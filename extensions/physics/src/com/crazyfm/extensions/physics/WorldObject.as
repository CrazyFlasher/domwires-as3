/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.JointDataVo;
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	import nape.geom.Vec2;
	import nape.phys.BodyList;
	import nape.space.Space;

	public class WorldObject implements IWorldObject
	{
		private var _space:Space;

		private var _data:WorldDataVo;

		private var _bodyObjectList:Vector.<IBodyObject>;
		private var _jointObjectList:Vector.<IJointObject>;

		public function WorldObject()
		{
		}

		public function set data(value:WorldDataVo):void
		{
			//TODO: dispose

			_data = value;

			_space = new Space(new Vec2(_data.gravity.x, _data.gravity.y));

			_bodyObjectList = new <IBodyObject>[];

			for each (var bodyData:BodyDataVo in _data.bodyDataList)
			{
				var bodyObject:IBodyObject = new BodyObject();
				bodyObject.data = bodyData;
				_bodyObjectList.push(bodyObject);

				_space.bodies.add(bodyObject.body);
			}

			_jointObjectList = new <IJointObject>[];

			for each (var jointData:JointDataVo in _data.jointDataList)
			{
				var jointObject:IJointObject = new JointObject();
				jointObject.data = jointData;

				var bodiesUnderJoint:BodyList = getBodiesUnderJoint(jointObject.data.x, jointObject.data.y);
				if(bodiesUnderJoint.length > 1)
				{
					jointObject.connect(bodiesUnderJoint.at(0), bodiesUnderJoint.at(1));
				}

				_jointObjectList.push(jointObject);

				_space.constraints.add(jointObject.joint);
			}
		}

		private function getBodiesUnderJoint(jointX:Number, jointY:Number):BodyList
		{
			return space.bodiesUnderPoint(new Vec2(jointX, jointY));
		}

		public function get data():WorldDataVo
		{
			return _data;
		}

		public function get bodyObjectList():Vector.<IBodyObject>
		{
			return _bodyObjectList;
		}

		public function get space():Space
		{
			return _space;
		}

		public function get jointObjectList():Vector.<IJointObject>
		{
			return _jointObjectList;
		}
	}
}
