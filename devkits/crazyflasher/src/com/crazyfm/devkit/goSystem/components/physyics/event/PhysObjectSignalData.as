/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.event
{
	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;
	import nape.shape.Shape;

	use namespace ns_collision_signaldata;

	public class PhysObjectSignalData
	{
		private var _collision:InteractionCallback;

		private var _otherBody:Body;
		private var _otherShape:Shape;

		public function PhysObjectSignalData()
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

		ns_collision_signaldata function setCollision(value:InteractionCallback):PhysObjectSignalData
		{
			_collision = value;

			return this;
		}

		ns_collision_signaldata function setOtherBody(value:Body):PhysObjectSignalData
		{
			_otherBody = value;

			return this;
		}

		ns_collision_signaldata function setOtherShape(value:Shape):PhysObjectSignalData
		{
			_otherShape = value;

			return this;
		}
	}
}
