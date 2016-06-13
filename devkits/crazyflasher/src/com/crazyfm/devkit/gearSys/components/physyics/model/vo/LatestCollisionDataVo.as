/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.physyics.model.vo
{
	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;
	import nape.shape.Shape;

	use namespace ns_collision_data;

	public class LatestCollisionDataVo
	{
		private var _collision:InteractionCallback;

		private var _otherBody:Body;
		private var _otherShape:Shape;

		public function LatestCollisionDataVo()
		{

		}

		public function get collision():InteractionCallback
		{
			return _collision;
		}

		public function get otherShape():Shape
		{
			return _otherShape;
		}

		ns_collision_data function setCollision(value:InteractionCallback):LatestCollisionDataVo
		{
			_collision = value;

			return this;
		}

		ns_collision_data function setOtherBody(value:Body):LatestCollisionDataVo
		{
			_otherBody = value;

			return this;
		}

		ns_collision_data function setOtherShape(value:Shape):LatestCollisionDataVo
		{
			_otherShape = value;

			return this;
		}
	}
}
