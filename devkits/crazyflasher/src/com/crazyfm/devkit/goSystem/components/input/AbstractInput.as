/**
 * Created by Anton Nefjodov on 29.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.input
{
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.extension.goSystem.GameComponent;

	public class AbstractInput extends GameComponent implements IInput
	{
		protected var controllableComponents:Array/*IControllable*/

		public function AbstractInput()
		{
			super();
		}

		public function sendActionToControllables(action:AbstractInputActionEnum):IInput
		{
			for each (var controllable:IControllable in controllableComponents)
			{
				controllable.inputAction(action);
			}

			return this;
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
