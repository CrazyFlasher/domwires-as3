/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;

	import nape.phys.Body;

	public class PhysBodyObject extends GameComponent implements IPhysBodyObject
	{
		private var _body:Body;

		public function PhysBodyObject(body:Body)
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
	}
}
