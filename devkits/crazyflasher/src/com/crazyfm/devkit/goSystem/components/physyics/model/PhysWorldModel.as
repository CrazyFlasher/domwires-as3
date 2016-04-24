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
	import nape.space.Space;

	public class PhysWorldModel extends GameComponent implements IPhysWorldModel
	{
		private var space:Space;

		private var interactors:CollisionInteractors;

		protected var velocityIterations:int = 10;
		protected var positionIterations:int = 10;

		public function PhysWorldModel(space:Space)
		{
			super();

			this.space = space;
			interactors = new CollisionInteractors();

			createPhysicsListeners();
		}

		protected function createPhysicsListeners():void
		{
			space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.ANY, CbType.ANY_BODY, CbType.ANY_SHAPE, bodyCollisionBeginHandler));
//			space.listeners.add(new InteractionListener(CbEvent.ONGOING, InteractionType.ANY, CbType.ANY_BODY, CbType.ANY_SHAPE, bodyOnGoingCollisionListener));
			space.listeners.add(new InteractionListener(CbEvent.END, InteractionType.ANY, CbType.ANY_BODY, CbType.ANY_SHAPE, bodyCollisionEndHandler));

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
			interactors.update(collision);

			interactors.po_1.onBodyBeginCollision(collision, interactors.otherBody, interactors.otherShape);
			interactors.po_2.onBodyBeginCollision(collision, interactors.currentBody, interactors.currentShape);
		}

		private function bodyOnGoingCollisionListener(collision:InteractionCallback):void
		{
			interactors.update(collision);

			interactors.po_1.onBodyOnGoingCollision(collision, interactors.otherBody, interactors.otherShape);
			interactors.po_2.onBodyOnGoingCollision(collision, interactors.currentBody, interactors.currentShape);
		}

		private function bodyCollisionEndHandler(collision:InteractionCallback):void
		{
			interactors.update(collision);

			interactors.po_1.onBodyEndCollision(collision, interactors.otherBody, interactors.otherShape);
			interactors.po_2.onBodyEndCollision(collision, interactors.currentBody, interactors.currentShape);
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

			space.step(timePassed, velocityIterations, positionIterations);
		}
	}
}

import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;

import nape.callbacks.InteractionCallback;
import nape.phys.Body;
import nape.shape.Shape;

internal class CollisionInteractors
{
	private var _currentBody:Body;
	private var _currentShape:Shape;
	private var _otherBody:Body;
	private var _otherShape:Shape;
	private var _po_1:IPhysBodyObjectModel;
	private var _po_2:IPhysBodyObjectModel;

	public function CollisionInteractors()
	{

	}

	public function update(collision:InteractionCallback):void
	{
		if (collision.int1.isBody())
		{
			_currentBody = collision.int1 as Body;
			_otherShape = collision.int2 as Shape;
		}else
		if (collision.int1.isShape())
		{
			_currentShape = collision.int1 as Shape;
			_otherBody = collision.int2 as Body;
		}

		if (currentBody)
		{
			_po_1 = currentBody.userData.clazz as IPhysBodyObjectModel;
		}else
		if (currentShape)
		{
			_po_1 = currentShape.body.userData.clazz as IPhysBodyObjectModel;
		}

		if (otherBody)
		{
			_po_2 = otherBody.userData.clazz as IPhysBodyObjectModel;
		}else
		if (otherShape)
		{
			_po_2 = otherShape.body.userData.clazz as IPhysBodyObjectModel;
		}
	}

	public function get currentBody():Body
	{
		return _currentBody;
	}

	public function get currentShape():Shape
	{
		return _currentShape;
	}

	public function get otherBody():Body
	{
		return _otherBody;
	}

	public function get otherShape():Shape
	{
		return _otherShape;
	}

	public function get po_1():IPhysBodyObjectModel
	{
		return _po_1;
	}

	public function get po_2():IPhysBodyObjectModel
	{
		return _po_2;
	}
}
