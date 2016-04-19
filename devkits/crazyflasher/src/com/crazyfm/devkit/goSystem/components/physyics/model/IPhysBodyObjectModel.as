/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;
	import nape.shape.Shape;

	public interface IPhysBodyObjectModel extends IGameComponent
	{
		function get body():Body;
		function onBodyBeginCollision(collision:InteractionCallback, currentShape:Shape, otherShape:Shape):void;
		function onBodyEndCollision(collision:InteractionCallback, currentShape:Shape, otherShape:Shape):void;
		function onBodyOnGoingCollision(collision:InteractionCallback, currentShape:Shape, otherShape:Shape):void;
	}
}
