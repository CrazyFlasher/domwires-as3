/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
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
	import nape.shape.Shape;
	import nape.space.Space;

	public class PhysWorldModel extends GameComponent implements IPhysWorldModel
	{
		private var space:Space;

		public function PhysWorldModel(space:Space)
		{
			super();

			this.space = space;

			createPhysicsListeners();
		}

		protected function createPhysicsListeners():void
		{
			space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.ANY, CbType.ANY_SHAPE, CbType.ANY_BODY, bodyCollisionBeginHandler));
			space.listeners.add(new InteractionListener(CbEvent.ONGOING, InteractionType.ANY, CbType.ANY_SHAPE, CbType.ANY_BODY, bodyOnGoingCollisionListener));
			space.listeners.add(new InteractionListener(CbEvent.END, InteractionType.ANY, CbType.ANY_SHAPE, CbType.ANY_BODY, bodyCollisionEndHandler));

//			space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.SENSOR, CbType.ANY_BODY, CbType.ANY_BODY, bodySensorBeginHandler));
//			space.listeners.add(new InteractionListener(CbEvent.ONGOING, InteractionType.SENSOR, CbType.ANY_BODY, CbType.ANY_BODY, bodyOnGoingSensorListener));
//			space.listeners.add(new InteractionListener(CbEvent.END, InteractionType.SENSOR, CbType.ANY_BODY, CbType.ANY_BODY, bodySensorEndHandler));

//			space.listeners.add(new PreListener(InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyPreCollisionHandler));
		}

		private function bodyPreCollisionHandler(preCollision:PreCallback):PreFlag
		{
			//TODO

			return PreFlag.ACCEPT;
		}

		private function bodyCollisionBeginHandler(collision:InteractionCallback):void
		{
			var po_1:IPhysBodyObjectModel = (collision.int1 as Shape).body.userData.clazz as IPhysBodyObjectModel;
			var po_2:IPhysBodyObjectModel = (collision.int2 as Shape).body.userData.clazz as IPhysBodyObjectModel;

			po_1.onBodyBeginCollision(collision, collision.int1 as Shape, collision.int2 as Shape);
			po_2.onBodyBeginCollision(collision, collision.int2 as Shape, collision.int1 as Shape);
		}

		private function bodyOnGoingCollisionListener(collision:InteractionCallback):void
		{
			var po_1:IPhysBodyObjectModel = (collision.int1 as Shape).body.userData.clazz as IPhysBodyObjectModel;
			var po_2:IPhysBodyObjectModel = (collision.int2 as Shape).body.userData.clazz as IPhysBodyObjectModel;

			po_1.onBodyOnGoingCollision(collision, collision.int1 as Shape, collision.int2 as Shape);
			po_2.onBodyOnGoingCollision(collision, collision.int2 as Shape, collision.int1 as Shape);
		}

		private function bodyCollisionEndHandler(collision:InteractionCallback):void
		{
			var po_1:IPhysBodyObjectModel = (collision.int1 as Shape).body.userData.clazz as IPhysBodyObjectModel;
			var po_2:IPhysBodyObjectModel = (collision.int2 as Shape).body.userData.clazz as IPhysBodyObjectModel;

			po_1.onBodyEndCollision(collision, collision.int1 as Shape, collision.int2 as Shape);
			po_2.onBodyEndCollision(collision, collision.int2 as Shape, collision.int1 as Shape);
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

			space.step(timePassed);
		}
	}
}
