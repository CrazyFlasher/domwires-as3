/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.goSystem.components.physyics.model.vo.ns_collision_data;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;
	import nape.shape.Shape;

	use namespace ns_collision_data;

	public class PhysBodyObjectModel extends GameComponent implements IPhysBodyObjectModel
	{
		private var _body:Body;

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

		public function get body():Body
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
			dispatchSignal(PhysObjectSignalEnum.COLLISION_BEGIN, latestCollisionData);
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
			dispatchSignal(PhysObjectSignalEnum.COLLISION_END, latestCollisionData);
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
			dispatchSignal(PhysObjectSignalEnum.COLLISION_ONGOING, latestCollisionData);
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
			dispatchSignal(PhysObjectSignalEnum.SENSOR_BEGIN, latestCollisionData);
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
			dispatchSignal(PhysObjectSignalEnum.SENSOR_END, latestCollisionData);
		}

		public function onBodyOnGoingSensor(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				updateLatestCollisionData(collision, otherBody, otherShape);

				handleOnGoingSensor();
			}
		}

		protected function handleOnGoingSensor():void
		{
			dispatchSignal(PhysObjectSignalEnum.SENSOR_ONGOING, latestCollisionData);
		}

		private function updateLatestCollisionData(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			latestCollisionData.setCollision(collision).setOtherBody(otherBody).setOtherShape(otherShape);
		}
	}
}