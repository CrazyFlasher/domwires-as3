/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.AbstractDisposable;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.extensions.physics.vo.units.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.units.JointDataVo;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.space.Space;

	public class WorldObject extends AbstractDisposable implements IWorldObject
	{
		[Autowired]
		public var factory:IAppFactory;

		private var _space:Space;

		private var _data:WorldDataVo;

		private var _bodyObjectList:Vector.<IBodyObject>;
		private var _jointObjectList:Vector.<IJointObject>;

		public function WorldObject(data:WorldDataVo)
		{
			super();

			_data = data;
		}

		[PostConstruct]
		public function init():void
		{
			_space = new Space(new Vec2(_data.gravity.x, _data.gravity.y));

			_bodyObjectList = new <IBodyObject>[];

			var bodyObject:IBodyObject;
			for each (var bodyData:BodyDataVo in _data.bodyDataList)
			{
				bodyObject = factory.getInstance(IBodyObject, [bodyData]);
				_bodyObjectList.push(bodyObject);

				_space.bodies.add(bodyObject.body);
			}

			_jointObjectList = new <IJointObject>[];

			var jointObject:IJointObject;
			var bodiesToConnect:Vector.<Body>;
			for each (var jointData:JointDataVo in _data.jointDataList)
			{
				jointObject = factory.getInstance(IJointObject, [jointData]);

				bodiesToConnect = getBodiesToConnect(jointObject.data);

				if(bodiesToConnect.length > 1)
				{
					jointObject.connect(bodiesToConnect[0], bodiesToConnect[1]);

					_space.constraints.add(jointObject.pivotJoint);

					if (jointObject.angleJoint != null)
					{
						_space.constraints.add(jointObject.angleJoint);
					}

					_jointObjectList.push(jointObject);
				}
			}

			_space.userData.dataObject = this;
		}

		private function getBodiesToConnect(data:JointDataVo):Vector.<Body>
		{
			var bodiesToConnect:Vector.<Body> = new <Body>[];

			if (data.bodyToConnectIdList && data.bodyToConnectIdList.length > 0)
			{
				for each (var bodyId:String in data.bodyToConnectIdList)
				{
					if (bodyId == "$world")
					{
						bodiesToConnect.push(_space.world);
					}else
					{
						for each (var bodyObject:IBodyObject in _bodyObjectList)
						{
							if (bodyObject.data.id == bodyId)
							{
								bodiesToConnect.push(bodyObject.body);
							}
						}
					}
				}
			}else
			{
				var bodiesUnderJoint:BodyList = getBodiesUnderJoint(data.x, data.y);
				for (var i:int = 0; i < bodiesUnderJoint.length; i++)
				{
					bodiesToConnect.push(bodiesUnderJoint.at(i));
				}
			}

			return bodiesToConnect;
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

		public function bodyObjectById(id:String):IBodyObject
		{
			for each (var bodyObject:IBodyObject in _bodyObjectList)
			{
				if (bodyObject.data.id == id)
				{
					return bodyObject;
				}
			}

			return null;
		}

		public function jointObjectById(id:String):IJointObject
		{
			for each (var jointObject:IJointObject in _jointObjectList)
			{
				if (jointObject.data.id == id)
				{
					return jointObject;
				}
			}

			return null;
		}

		override public function dispose():void
		{
			for each (var bodyObject:IBodyObject in _bodyObjectList)
			{
				bodyObject.dispose();
			}
			for each (var jointObject:IJointObject in _jointObjectList)
			{
				jointObject.dispose();
			}

			_space.bodies.clear();

			_bodyObjectList = null;
			_jointObjectList = null;
			_space = null;
			_data = null;
			factory = null;

			super.dispose();
		}

		public function clone():IWorldObject
		{
			var c:IWorldObject = factory.getInstance(IWorldObject, [_data]);
			return c;
		}
	}
}
