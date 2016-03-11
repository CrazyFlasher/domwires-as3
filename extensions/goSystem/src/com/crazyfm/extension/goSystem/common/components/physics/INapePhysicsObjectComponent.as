/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem.common.components.physics
{
	import com.crazyfm.extension.goSystem.IGameComponent;
	import com.crazyfm.extension.goSystem.common.components.view.IViewComponent;

	import nape.callbacks.InteractionCallback;

	public interface INapePhysicsObjectComponent extends IGameComponent
	{
		function onBodyBeginCollision(collision:InteractionCallback):void;
		function setView(value:IViewComponent):INapePhysicsObjectComponent;
	}
}
