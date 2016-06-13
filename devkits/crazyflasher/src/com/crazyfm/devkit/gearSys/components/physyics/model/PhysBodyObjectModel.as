/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.gearSys.components.physyics.model
{
	import com.crazyfm.devkit.gearSys.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.gearSys.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.gearSys.components.physyics.model.vo.ns_collision_data;
	import com.crazyfm.extension.gearSys.GearSysComponent;

	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Shape;

	use namespace ns_collision_data;

	public class PhysBodyObjectModel extends GearSysComponent implements IPhysBodyObjectModel
	{
		protected var _body:Body;

		protected var latestCollisionData:LatestCollisionDataVo;

		public function PhysBodyObjectModel(body:Body)
		{
			super();

			_body = body;

			latestCollisionData = new LatestCollisionDataVo();

			if (_body.isDynamic())
			{
				removeInteractionCallbacksFromShapes();
			}

			_body.userData.clazz = this;
		}

		private function removeInteractionCallbacksFromShapes():void
		{
			var shape:Shape;
			for (var i:int = 0; i < _body.shapes.length; i++)
			{
				shape = _body.shapes.at(i);
				shape.cbTypes.clear();
			}
		}

		override public function dispose():void
		{
			_body = null;
			latestCollisionData = null;

			super.dispose();
		}

		ns_inter_physobject function get body():Body
		{
			return _body;
		}

		public function onBodyBeginCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				updateLatestCollisionData(collision, otherBody, otherShape);

				handleBeginCollision();
			}
		}

		protected function handleBeginCollision():void
		{
			dispatchMessage(PhysObjectSignalEnum.COLLISION_BEGIN, latestCollisionData);
		}

		public function onBodyEndCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				updateLatestCollisionData(collision, otherBody, otherShape);

				handleEndCollision();
			}
		}

		protected function handleEndCollision():void
		{
			dispatchMessage(PhysObjectSignalEnum.COLLISION_END, latestCollisionData);
		}

		public function onBodyOnGoingCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				updateLatestCollisionData(collision, otherBody, otherShape);

				handleOnGoingCollision();
			}
		}

		protected function handleOnGoingCollision():void
		{
			dispatchMessage(PhysObjectSignalEnum.COLLISION_ONGOING, latestCollisionData);
		}

		public function onBodyBeginSensor(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				updateLatestCollisionData(collision, otherBody, otherShape);

				handleBeginSensor();
			}
		}

		private function handleBeginSensor():void
		{
			dispatchMessage(PhysObjectSignalEnum.SENSOR_BEGIN, latestCollisionData);
		}

		public function onBodyEndSensor(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				updateLatestCollisionData(collision, otherBody, otherShape);

				handleEndSensor();
			}
		}

		protected function handleEndSensor():void
		{
			dispatchMessage(PhysObjectSignalEnum.SENSOR_END, latestCollisionData);
		}

		public function onBodyOnGoingSensor(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				updateLatestCollisionData(collision, otherBody, otherShape);

				handleOnGoingSensor();
			}
		}

		public function onBodyPreCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
		}

		protected function handleOnGoingSensor():void
		{
			dispatchMessage(PhysObjectSignalEnum.SENSOR_ONGOING, latestCollisionData);
		}

		private function updateLatestCollisionData(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			latestCollisionData.setCollision(collision).setOtherBody(otherBody).setOtherShape(otherShape);
		}

		public function get position():Vec2
		{
			return _body.position;
		}

		public function get velocity():Vec2
		{
			return _body.velocity;
		}

		public function get rotation():Number
		{
			return _body.rotation;
		}

		public function set rotation(value:Number):void
		{
			_body.rotation = value;
		}

		public function get localCenterOfMass():Vec2
		{
			return _body.localCOM;
		}

		public function get worldCenterOfMass():Vec2
		{
			return _body.worldCOM;
		}
	}
}
