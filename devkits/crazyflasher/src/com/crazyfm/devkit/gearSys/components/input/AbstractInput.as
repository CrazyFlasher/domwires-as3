/**
 * Created by Anton Nefjodov on 29.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.input
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.devkit.gearSys.components.controllable.IControllable;
	import com.crazyfm.extension.gearSys.GearSysComponent;

	use namespace ns_input;

	public class AbstractInput extends GearSysComponent implements IInput
	{
		protected var controllableComponents:Array/*IControllable*/;

		protected var actionVo:AbstractInputActionVo;

		public function AbstractInput()
		{
			super();
		}

		public function sendActionToControllables(action:Enum):IInput
		{
			updateActionVo(action);

			for each (var controllable:IControllable in controllableComponents)
			{
				controllable.inputAction(actionVo);
			}

			return this;
		}

		protected function updateActionVo(action:Enum):AbstractInputActionVo
		{
			actionVo = getInstance(AbstractInputActionVo)
				.setAction(action);

			return actionVo;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!controllableComponents)
			{
				controllableComponents = gameObject.getComponentsByType(IControllable);
			}
		}
	}
}
