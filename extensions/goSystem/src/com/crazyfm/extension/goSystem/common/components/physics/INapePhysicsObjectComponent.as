/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.physics
{
	import nape.callbacks.InteractionCallback;

	public interface INapePhysicsObjectComponent
	{
		function onBodyBeginCollision(collision:InteractionCallback):void;
	}
}
