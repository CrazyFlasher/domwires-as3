/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.extension.goSystem.GameComponent;
	import com.crazyfm.extensions.physics.IBodyObject;

	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	import nape.hacks.ForcedSleep;
	import nape.phys.Body;

	public class PhysBodyObjectModel extends GameComponent implements IPhysBodyObjectModel
	{
		private var _body:Body;

		public function PhysBodyObjectModel(bodyObject:IBodyObject)
		{
			super();

			_body = bodyObject.body;

			_body.userData.clazz = this;
		}

		override public function dispose():void
		{
			_body = null;

			super.dispose();
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

		public function setVelocityX(value:Number):IPhysBodyObjectModel
		{
			_body.velocity.setxy(value, _body.velocity.y);

			return this;
		}

		public function setVelocityY(value:Number):IPhysBodyObjectModel
		{
			_body.velocity.setxy(_body.velocity.x, value);

			return this;
		}

		public function get velocityX():Number
		{
			return _body.velocity.x;
		}

		public function get velocityY():Number
		{
			return _body.velocity.y;
		}

		public function setRotation(value:Number):IPhysBodyObjectModel
		{
			_body.rotation = value

			return this;
		}

		public function setAllowRotation(value:Boolean):IPhysBodyObjectModel
		{
			_body.allowRotation = value

			return this;
		}

		public function putToSleep():IPhysBodyObjectModel
		{
			_body.velocity.setxy(0, 0);
			ForcedSleep.sleepBody(_body);

			return this;
		}

		public function worldVectorToLocal(input:Vec2):Vec2
		{
			return _body.worldVectorToLocal(input);
		}
	}
}
