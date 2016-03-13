/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.physics
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;

	public class PhysicsObjectComponent extends GameComponent implements IPhysicsObjectComponent
	{
		public function PhysicsObjectComponent()
		{
			super();
		}

		public function onBodyBeginCollision(collision:InteractionCallback):void
		{

		}
	}
}
