/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.controllable
{
	import com.crazyfm.core.mvc.message.IMessage;
	import com.crazyfm.devkit.gearSys.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.gearSys.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.gearSys.components.physyics.model.IInteractivePhysObjectModel;
	import com.crazyfm.extension.gearSys.GearSysComponent;

	public class AbstractPhysControllable extends GearSysComponent implements IControllable
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

			intPhysObject.addMessageListener(PhysObjectSignalEnum.COLLISION_BEGIN, handleCollisionBegin);
			intPhysObject.addMessageListener(PhysObjectSignalEnum.COLLISION_ONGOING, handleCollisionOngoing);
			intPhysObject.addMessageListener(PhysObjectSignalEnum.COLLISION_END, handleCollisionEnd);

			intPhysObject.addMessageListener(PhysObjectSignalEnum.SENSOR_BEGIN, handleSensorBegin);
			intPhysObject.addMessageListener(PhysObjectSignalEnum.SENSOR_ONGOING, handleSensorOngoing);
			intPhysObject.addMessageListener(PhysObjectSignalEnum.SENSOR_END, handleSensorEnd);
		}

		protected function handleCollisionOngoing(e:IMessage):void
		{
			trace("handleCollisionOngoing")
		}

		protected function handleCollisionBegin(e:IMessage):void
		{
			trace("handleCollisionBegin")
		}

		protected function handleCollisionEnd(e:IMessage):void
		{
			trace("handleCollisionEnd")
		}

		protected function handleSensorBegin(e:IMessage):void
		{

		}

		protected function handleSensorEnd(e:IMessage):void
		{

		}

		protected function handleSensorOngoing(e:IMessage):void
		{

		}

		public function inputAction(actionVo:AbstractInputActionVo):IControllable
		{
			inputActions.push(actionVo);

			return this;
		}

		protected function handleInputAction(actionVo:AbstractInputActionVo):void
		{

		}

		override public function dispose():void
		{
			intPhysObject.removeMessageListener(PhysObjectSignalEnum.COLLISION_BEGIN, handleCollisionBegin);
			intPhysObject.removeMessageListener(PhysObjectSignalEnum.COLLISION_ONGOING, handleCollisionOngoing);
			intPhysObject.removeMessageListener(PhysObjectSignalEnum.COLLISION_END, handleCollisionEnd);

			intPhysObject.removeMessageListener(PhysObjectSignalEnum.SENSOR_BEGIN, handleSensorBegin);
			intPhysObject.removeMessageListener(PhysObjectSignalEnum.SENSOR_END, handleSensorEnd);

			intPhysObject = null;
			inputActions = null;

			super.dispose();
		}
	}
}
