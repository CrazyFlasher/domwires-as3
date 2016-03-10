/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.physics
{
	import com.crazyfm.extension.goSystem.GameComponent;
	import com.crazyfm.extension.goSystem.IGameComponent;

	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.callbacks.PreCallback;
	import nape.callbacks.PreFlag;
	import nape.callbacks.PreListener;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.space.Space;

	public class NapePhysicsWorldComponent extends GameComponent implements INapePhysicsWorldComponent
	{
		private var space:Space;

		protected var velocityIterations:int = 10;
		protected var positionIterations:int = 10;
		protected var gravityX:Number = 0;
		protected var gravityY:Number = 9.8;

		public function NapePhysicsWorldComponent()
		{
			super();

			init();
		}

		private function init():void
		{
			if (space)
			{
				throw new Error("Space already created!");
			}

			space = new Space(new Vec2(gravityX, gravityY));

			createPhysicsListeners();
		}

		protected function createPhysicsListeners():void
		{
			var bodyBeginCollisionListener:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyCollisionBeginHandler);
			var bodyPreCollisionListener:PreListener = new PreListener(InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyPreCollisionHandler);

			space.listeners.add(bodyBeginCollisionListener);
			space.listeners.add(bodyPreCollisionListener);
		}

		private function bodyPreCollisionHandler(preCollision:PreCallback):PreFlag
		{
			//TODO
		}

		private function bodyCollisionBeginHandler(collision:InteractionCallback):void
		{
			var po_1:INapePhysicsObjectComponent = (collision.int1 as Body).userData.clazz as INapePhysicsObjectComponent;
			var po_2:INapePhysicsObjectComponent = (collision.int2 as Body).userData.clazz as INapePhysicsObjectComponent;

			po_1.onBodyBeginCollision(collision);
			po_2.onBodyBeginCollision(collision);
		}

		override public function advanceTime(time:Number):void
		{
			super.advanceTime(time);

			if (space)
			{
				space.step(time, velocityIterations, positionIterations);
			}
		}

		override public function dispose():void
		{
			space.listeners.clear();
			space.clear();

			space = null;

			super.dispose();
		}
	}
}
