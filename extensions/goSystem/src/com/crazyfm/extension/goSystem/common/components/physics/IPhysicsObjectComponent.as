/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.physics
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	import nape.callbacks.InteractionCallback;

	public interface IPhysicsObjectComponent extends IGameComponent
	{
		function onBodyBeginCollision(collision:InteractionCallback):void;
	}
}
