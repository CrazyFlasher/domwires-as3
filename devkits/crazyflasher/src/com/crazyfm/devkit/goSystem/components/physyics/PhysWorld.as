/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.callbacks.PreCallback;
	import nape.callbacks.PreFlag;
	import nape.callbacks.PreListener;
	import nape.phys.Body;
	import nape.space.Space;

	public class PhysWorld extends GameComponent implements IPhysWorld
	{
		private var space:Space;

		public function PhysWorld(space:Space)
		{
			super();

			this.space = space;

			createPhysicsListeners();
		}

		protected function createPhysicsListeners():void
		{
			space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyCollisionBeginHandler));
			space.listeners.add(new InteractionListener(CbEvent.ONGOING, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyOnGoingCollisionListener));
			space.listeners.add(new InteractionListener(CbEvent.END, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyCollisionEndHandler));

			space.listeners.add(new PreListener(InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyPreCollisionHandler));
		}

		private function bodyPreCollisionHandler(preCollision:PreCallback):PreFlag
		{
			//TODO

			return PreFlag.ACCEPT;
		}

		private function bodyCollisionBeginHandler(collision:InteractionCallback):void
		{
			var po_1:IPhysBodyObject = (collision.int1 as Body).userData.clazz as IPhysBodyObject;
			var po_2:IPhysBodyObject = (collision.int2 as Body).userData.clazz as IPhysBodyObject;

			po_1.onBodyBeginCollision(collision);
			po_2.onBodyBeginCollision(collision);
		}

		private function bodyOnGoingCollisionListener(collision:InteractionCallback):void
		{
			var po_1:IPhysBodyObject = (collision.int1 as Body).userData.clazz as IPhysBodyObject;
			var po_2:IPhysBodyObject = (collision.int2 as Body).userData.clazz as IPhysBodyObject;

			po_1.onBodyOnGoingCollision(collision);
			po_2.onBodyOnGoingCollision(collision);
		}

		private function bodyCollisionEndHandler(collision:InteractionCallback):void
		{
			var po_1:IPhysBodyObject = (collision.int1 as Body).userData.clazz as IPhysBodyObject;
			var po_2:IPhysBodyObject = (collision.int2 as Body).userData.clazz as IPhysBodyObject;

			po_1.onBodyEndCollision(collision);
			po_2.onBodyEndCollision(collision);
		}

		override public function dispose():void
		{
			space.listeners.clear();
			space.clear();

			space = null;

			super.dispose();
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (space)
			{
				space.step(timePassed);
			}

		}
	}
}
