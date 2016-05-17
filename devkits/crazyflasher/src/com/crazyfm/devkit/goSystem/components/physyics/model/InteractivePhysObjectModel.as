/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import nape.callbacks.InteractionCallback;
	import nape.geom.AABB;
	import nape.geom.Vec2;
	import nape.hacks.ForcedSleep;
	import nape.phys.Body;
	import nape.phys.GravMassMode;

	import starling.animation.DelayedCall;

	public class InteractivePhysObjectModel extends PhysBodyObjectModel implements IInteractivePhysObjectModel
	{
		private const SLEEP_VELOCITY:Vec2 = new Vec2(10, 10);
		private const IS_ON_LEGS_COLLISION_Y:Number = 0.65;

		private var _isOnLegs:Boolean;
		private var gravityMass:Number;

		//need to prevent nape lib bug, after putting object manually to sleep.
		private var collisionJustEnded:Boolean;

		//TODO: connect to mechanism;
		private var delayedCall:DelayedCall;
		private var _isTeleporting:Boolean;

		public function InteractivePhysObjectModel(body:Body)
		{
			super(body);

			gravityMass = _body.gravMass;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (_isOnLegs && _body.velocity.length < SLEEP_VELOCITY.length && !collisionJustEnded)
			{
				tryToSleep();
			}

			if (collisionJustEnded)
			{
				collisionJustEnded = false;
			}
		}

		override protected function handleBeginCollision():void
		{
			_isOnLegs = computeIsOnLegs(latestCollisionData.collision);

			super.handleBeginCollision();
		}


		override protected function handleEndCollision():void
		{
			_isOnLegs = computeIsOnLegs(latestCollisionData.collision);

			super.handleEndCollision();

			collisionJustEnded = true;
		}

		override protected function handleOnGoingCollision():void
		{
			_isOnLegs = computeIsOnLegs(latestCollisionData.collision);

			super.handleOnGoingCollision();
		}

		protected function tryToSleep():void
		{
			if (!_body.isSleeping)
			{
				_body.velocity.setxy(0, 0);

				ForcedSleep.sleepBody(_body);
			}
		}

		public function get isOnLegs():Boolean
		{
			return _isOnLegs;
		}

		private function computeIsOnLegs(collision:InteractionCallback):Boolean
		{
			if (collision.arbiters.length == 0) return false;

			for (var i:int = 0; i < collision.arbiters.length; i++)
			{
				if (_body.worldVectorToLocal(collision.arbiters.at(i).collisionArbiter.normal).y < IS_ON_LEGS_COLLISION_Y)
				{
					return false;
				}
			}

			return true;
		}

		public function setZeroGravity(value:Boolean):IInteractivePhysObjectModel
		{
			if (value)
			{
				_body.gravMass = 0;
			}else
			{
				_body.gravMass = gravityMass;
				_body.gravMassMode = GravMassMode.DEFAULT;
			}

			return this;
		}

		public function get zeroGravity():Boolean
		{
			return _body.gravMass == 0;
		}

		public function get bounds():AABB
		{
			return _body.bounds;
		}

		public function teleportTo(x:Number, y:Number, time:int = 0):IInteractivePhysObjectModel
		{
			_isTeleporting = true;

			if (time == 0)
			{
				completeTeleport(x, y);
			}else
			{
				if (!delayedCall)
				{
					delayedCall = new DelayedCall(completeTeleport, time, [x, y]);
				}else
				{
					delayedCall.reset(completeTeleport, time, [x, y]);
				}
			}

			return this;
		}

		private function completeTeleport(x:Number, y:Number):void
		{
			position.setxy(x, y);

			_isTeleporting = false;
		}

		public function get isTeleporting():Boolean
		{
			return _isTeleporting;
		}
	}
}
