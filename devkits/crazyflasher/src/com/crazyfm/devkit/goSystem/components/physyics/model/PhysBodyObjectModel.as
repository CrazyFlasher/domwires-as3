/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalData;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.event.ns_collision_signaldata;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;
	import nape.shape.Shape;

	use namespace ns_collision_signaldata;

	public class PhysBodyObjectModel extends GameComponent implements IPhysBodyObjectModel
	{
		private var _body:Body;

		private var signalData:PhysObjectSignalData;

		public function PhysBodyObjectModel(body:Body)
		{
			super();

			_body = body;

			signalData = new PhysObjectSignalData();

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
			signalData = null;

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
				signalData.setCollision(collision).setOtherBody(otherBody).setOtherShape(otherShape);

				dispatchSignal(PhysObjectSignalEnum.COLLISION_BEGIN, signalData);
			}
		}

		public function onBodyEndCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				signalData.setCollision(collision).setOtherBody(otherBody).setOtherShape(otherShape);

				dispatchSignal(PhysObjectSignalEnum.COLLISION_END, signalData);
			}
		}

		public function onBodyOnGoingCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				signalData.setCollision(collision).setOtherBody(otherBody).setOtherShape(otherShape);

				dispatchSignal(PhysObjectSignalEnum.COLLISION_ONGOING, signalData);
			}
		}
	}
}
