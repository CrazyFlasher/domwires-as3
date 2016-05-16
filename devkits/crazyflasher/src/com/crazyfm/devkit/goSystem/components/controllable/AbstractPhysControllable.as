/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.controllable
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IInteractivePhysObjectModel;
	import com.crazyfm.devkit.physics.ICFShapeObject;
	import com.crazyfm.extension.goSystem.GOSystemComponent;

	import nape.shape.Shape;

	public class AbstractPhysControllable extends GOSystemComponent implements IControllable
	{
		protected var intPhysObject:IInteractivePhysObjectModel;

		public function AbstractPhysControllable()
		{
			super();
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!intPhysObject)
			{
				initialize();
			}
		}

		protected function initialize():void
		{
			intPhysObject = gameObject.getComponentByType(IInteractivePhysObjectModel) as IInteractivePhysObjectModel;

			intPhysObject.addSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, handleCollisionBegin);
			intPhysObject.addSignalListener(PhysObjectSignalEnum.COLLISION_ONGOING, handleCollisionOngoing);
			intPhysObject.addSignalListener(PhysObjectSignalEnum.COLLISION_END, handleCollisionEnd);

			intPhysObject.addSignalListener(PhysObjectSignalEnum.SENSOR_BEGIN, handleSensorBegin);
			intPhysObject.addSignalListener(PhysObjectSignalEnum.SENSOR_ONGOING, handleSensorOngoing);
			intPhysObject.addSignalListener(PhysObjectSignalEnum.SENSOR_END, handleSensorEnd);
		}

		protected function handleCollisionOngoing(e:ISignalEvent):void
		{
//			trace("handleCollisionOngoing")
		}

		protected function handleCollisionBegin(e:ISignalEvent):void
		{
//			trace("handleCollisionBegin")
		}

		protected function handleCollisionEnd(e:ISignalEvent):void
		{
//			trace("handleCollisionEnd")
		}

		protected function handleSensorBegin(e:ISignalEvent):void
		{

		}

		protected function handleSensorEnd(e:ISignalEvent):void
		{

		}

		protected function handleSensorOngoing(e:ISignalEvent):void
		{

		}

		public function inputAction(actionVo:AbstractInputActionVo):IControllable
		{
			return this;
		}

		override public function dispose():void
		{
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, handleCollisionBegin);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.COLLISION_ONGOING, handleCollisionOngoing);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.COLLISION_END, handleCollisionEnd);

			intPhysObject.removeSignalListener(PhysObjectSignalEnum.SENSOR_BEGIN, handleSensorBegin);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.SENSOR_END, handleSensorEnd);

			intPhysObject = null;

			super.dispose();
		}

		//TODO: do other way!
		/**
		 * Checks if shape is ladder
		 * @param shape
		 * @return x position or NaN
		 */
		/*protected final function isLadder(shape:Shape):Number
		{
			if (shape.userData.dataObject is ICFShapeObject)
			{
				return (shape.userData.dataObject as ICFShapeObject).isLadder ? shape.bounds.min.x : NaN;
			}

			return NaN;
		}

		protected final function canLeaveLadder(shape:Shape):Boolean
		{
			return isLadder(shape) && shape.bounds.min.y > intPhysObject.bounds.min.y;
		}*/
	}
}
