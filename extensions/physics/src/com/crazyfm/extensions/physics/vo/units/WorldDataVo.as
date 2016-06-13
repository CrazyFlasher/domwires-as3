/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo.units
{
	import com.crazyfm.extensions.physics.factory.PhysFactory;
	import com.crazyfm.extensions.physics.vo.GravityVo;

	public class WorldDataVo extends PhysicsUnitDataVo
	{
		private var _gravity:GravityVo = new GravityVo();

		private var _bodyDataList:Vector.<BodyDataVo>;
		private var _jointDataList:Vector.<JointDataVo>;

		public function WorldDataVo(json:Object)
		{
			super(json);

			var bodies:Vector.<BodyDataVo> = new <BodyDataVo>[];
			for each (var bodyJson:Object in json.bodies)
			{
				var bodyData:BodyDataVo = PhysFactory.instance.getInstance(BodyDataVo, bodyJson);
				bodies.push(bodyData);
			}

			var joints:Vector.<JointDataVo> = new <JointDataVo>[];
			for each (var jointJson:Object in json.joints)
			{
				var jointData:JointDataVo = PhysFactory.instance.getInstance(JointDataVo, jointJson);
				joints.push(jointData);
			}

			_bodyDataList = bodies;
			_jointDataList = joints;
			_gravity = PhysFactory.instance.getInstance(GravityVo, json.gravity.x, json.gravity.y);
		}

		public function get bodyDataList():Vector.<BodyDataVo>
		{
			return _bodyDataList;
		}

		public function get gravity():GravityVo
		{
			return _gravity;
		}

		public function get jointDataList():Vector.<JointDataVo>
		{
			return _jointDataList;
		}
	}
}
