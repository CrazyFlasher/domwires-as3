/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;

	public interface IPhysBodyObject extends IGameComponent
	{
		function get body():Body;
		function onBodyBeginCollision(collision:InteractionCallback):void;
		function onBodyEndCollision(collision:InteractionCallback):void;
		function onBodyOnGoingCollision(collision:InteractionCallback):void;
	}
}
