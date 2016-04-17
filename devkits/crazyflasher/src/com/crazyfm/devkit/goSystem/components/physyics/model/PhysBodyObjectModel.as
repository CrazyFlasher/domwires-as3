/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.dynamics.ArbiterList;
	import nape.phys.Body;

	public class PhysBodyObjectModel extends GameComponent implements IPhysBodyObjectModel
	{
		private var _body:Body;

		public function PhysBodyObjectModel(body:Body)
		{
			super();

			_body = body;

			_body.userData.clazz = this;
		}

		override public function dispose():void
		{
			_body = null;

			super.dispose();
		}

		public function get body():Body
		{
			return _body;
		}

		public function onBodyBeginCollision(collision:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				dispatchSignal(PhysObjectSignalEnum.COLLISION_BEGIN, collision);
			}
		}

		public function onBodyEndCollision(collision:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				dispatchSignal(PhysObjectSignalEnum.COLLISION_END, collision);
			}
		}

		public function onBodyOnGoingCollision(collision:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				dispatchSignal(PhysObjectSignalEnum.COLLISION_ONGOING, collision);
			}
		}

		private function hasSensorShape(arbiters:ArbiterList):Boolean
		{
			for (var i:int = 0; i < arbiters.length; i++)
			{
				if (arbiters.at(i).shape1.sensorEnabled || arbiters.at(i).shape2.sensorEnabled)
				{
					return true;
				}
			}

			return false;
		}

		public function onBodyBeginSensor(collision:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				dispatchSignal(PhysObjectSignalEnum.SENSOR_BEGIN, collision);
			}
		}

		public function onBodyEndSensor(collision:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				dispatchSignal(PhysObjectSignalEnum.SENSOR_END, collision);
			}
		}

		public function onBodyOnGoingSensor(collision:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				dispatchSignal(PhysObjectSignalEnum.SENSOR_ONGOING, collision);
			}
		}
	}
}
