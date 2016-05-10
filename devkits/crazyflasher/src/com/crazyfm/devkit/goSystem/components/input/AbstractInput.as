/**
 * Created by Anton Nefjodov on 29.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.input
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.extension.goSystem.GOSystemComponent;

	use namespace ns_input;

	public class AbstractInput extends GOSystemComponent implements IInput
	{
		protected var controllableComponents:Array/*IControllable*/

		protected var actionVo:AbstractInputActionVo;

		public function AbstractInput()
		{
			super();

			createActionVo();
		}

		protected function createActionVo():void
		{
			actionVo = new AbstractInputActionVo();
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
			actionVo.setAction(action);

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
