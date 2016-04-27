/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import nape.callbacks.InteractionCallback;
	import nape.hacks.ForcedSleep;
	import nape.phys.Body;

	public class InteractivePhysObjectModel extends PhysBodyObjectModel implements IInteractivePhysObjectModel
	{
		private var _isOnLegs:Boolean;

		//need to prevent nape lib bug, after putting object manually to sleep.
		private var collisionJustEnded:Boolean;

		public function InteractivePhysObjectModel(body:Body)
		{
			super(body);
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

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
			super.handleEndCollision();

			collisionJustEnded = true;
		}

		public function tryToSleep():void
		{
			if (!body.isSleeping && !collisionJustEnded)
			{
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
				if (body.worldVectorToLocal(collision.arbiters.at(i).collisionArbiter.normal).y < 0.3)
				{
					return false;
				}
			}

			return true;
		}
	}
}
