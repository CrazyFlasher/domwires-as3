/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.controllable
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IInteractivePhysObjectModel;
	import com.crazyfm.extension.goSystem.GOSystemComponent;

	public class AbstractPhysControllable extends GOSystemComponent implements IControllable
	{
		protected var intPhysObject:IInteractivePhysObjectModel;

		private var inputActions:Vector.<AbstractInputActionVo> = new <AbstractInputActionVo>[];

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

			if (intPhysObject.isEnabledForInteraction)
			{
				for each (var actionVo:AbstractInputActionVo in inputActions)
				{
					handleInputAction(actionVo);
				}
			}

			inputActions.length = 0;
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
			inputActions.push(actionVo.clone());

			return this;
		}

		protected function handleInputAction(actionVo:AbstractInputActionVo):void
		{

		}

		override public function dispose():void
		{
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, handleCollisionBegin);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.COLLISION_ONGOING, handleCollisionOngoing);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.COLLISION_END, handleCollisionEnd);

			intPhysObject.removeSignalListener(PhysObjectSignalEnum.SENSOR_BEGIN, handleSensorBegin);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.SENSOR_END, handleSensorEnd);

			intPhysObject = null;
			inputActions = null;

			super.dispose();
		}
	}
}
