/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.event
{
	import nape.callbacks.InteractionCallback;
	import nape.shape.Shape;

	use namespace ns_collision_signaldata;

	public class PhysObjectSignalData
	{
		private var _collision:InteractionCallback;
		private var _currentShape:Shape;
		private var _otherShape:Shape;

		public function PhysObjectSignalData()
		{

		}

		public function get collision():InteractionCallback
		{
			return _collision;
		}

		public function get currentShape():Shape
		{
			return _currentShape;
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

		ns_collision_signaldata function setCurrentShape(value:Shape):PhysObjectSignalData
		{
			_currentShape = value;

			return this;
		}

		ns_collision_signaldata function setOtherShape(value:Shape):PhysObjectSignalData
		{
			_otherShape = value;

			return this;
		}
	}
}
