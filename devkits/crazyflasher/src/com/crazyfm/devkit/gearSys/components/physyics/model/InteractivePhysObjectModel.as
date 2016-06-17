/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.physyics.model
{
	import com.crazyfm.devkit.gearSys.components.physyics.event.InteractivePhysObjectSignalEnum;

	import nape.callbacks.InteractionCallback;
	import nape.geom.AABB;
	import nape.geom.Vec2;
	import nape.hacks.ForcedSleep;
	import nape.phys.GravMassMode;

	import starling.animation.DelayedCall;
	import starling.animation.Juggler;

	public class InteractivePhysObjectModel extends PhysBodyObjectModel implements IInteractivePhysObjectModel
	{
		private const SLEEP_VELOCITY:Vec2 = new Vec2(10, 10);
		private const IS_ON_LEGS_COLLISION_Y:Number = 0.65;

		[Autowired]
		public var juggler:Juggler;

		private var _isOnLegs:Boolean;
		private var gravityMass:Number;

		//need to prevent nape lib bug, after putting object manually to sleep.
		private var collisionJustEnded:Boolean;

		//TODO: connect to mechanism;
		private var delayedCall:DelayedCall;
		private var _isTeleporting:Boolean;

		public function InteractivePhysObjectModel()
		{
			super();
		}

		[PostConstruct]
		override public function init():void
		{
			super.init();

			gravityMass = body.gravMass;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (_isOnLegs && body.velocity.length < SLEEP_VELOCITY.length && !collisionJustEnded)
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
			if (!body.isSleeping)
			{
				body.velocity.setxy(0, 0);

				ForcedSleep.sleepBody(body);
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
				if (body.worldVectorToLocal(collision.arbiters.at(i).collisionArbiter.normal, true).y < IS_ON_LEGS_COLLISION_Y)
				{
					return false;
				}
			}

			return true;
		}

		public function setZeroGravity(value:Boolean):IInteractivePhysObjectModel
		{
			if (isEnabledForInteraction)
			{
				if (value)
				{
					body.gravMass = 0;
				}else
				{
					body.gravMass = gravityMass;
					body.gravMassMode = GravMassMode.DEFAULT;
				}
			}

			return this;
		}

		public function get zeroGravity():Boolean
		{
			return body.gravMass == 0;
		}

		public function get bounds():AABB
		{
			return body.bounds;
		}

		public function teleportTo(x:Number, y:Number, time:Number = 0):IInteractivePhysObjectModel
		{
			velocity.setxy(0, 0);
			setZeroGravity(true);

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

				juggler.add(delayedCall);
			}

			return this;
		}

		private function completeTeleport(x:Number, y:Number):void
		{
			position.setxy(x, y);

			_isTeleporting = false;

			setZeroGravity(false);

			dispatchMessage(InteractivePhysObjectSignalEnum.TELEPORT_COMPLETE);
		}

		public function get isTeleporting():Boolean
		{
			return _isTeleporting;
		}

		public function get isEnabledForInteraction():Boolean
		{
			return !_isTeleporting;
		}
	}
}
