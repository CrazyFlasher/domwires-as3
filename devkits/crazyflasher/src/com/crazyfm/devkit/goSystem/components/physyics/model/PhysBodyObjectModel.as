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
	import nape.dynamics.ArbiterList;
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

			_body.userData.clazz = this;
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

		public function onBodyBeginCollision(collision:InteractionCallback, currentShape:Shape, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				signalData.setCollision(collision).setCurrentShape(currentShape).setOtherShape(otherShape);

				dispatchSignal(PhysObjectSignalEnum.COLLISION_BEGIN, signalData);
			}
		}

		public function onBodyEndCollision(collision:InteractionCallback, currentShape:Shape, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				signalData.setCollision(collision).setCurrentShape(currentShape).setOtherShape(otherShape);

				dispatchSignal(PhysObjectSignalEnum.COLLISION_END, signalData);
			}
		}

		public function onBodyOnGoingCollision(collision:InteractionCallback, currentShape:Shape, otherShape:Shape):void
		{
			if (!_body.isStatic())
			{
				signalData.setCollision(collision).setCurrentShape(currentShape).setOtherShape(otherShape);

				dispatchSignal(PhysObjectSignalEnum.COLLISION_ONGOING, signalData);
			}
		}
	}
}
