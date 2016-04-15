/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;

	public interface IPhysBodyObjectModel extends IGameComponent
	{
		function onBodyBeginCollision(collision:InteractionCallback):void;
		function onBodyEndCollision(collision:InteractionCallback):void;
		function onBodyOnGoingCollision(collision:InteractionCallback):void;

		function setVelocityX(value:Number):IPhysBodyObjectModel;
		function setVelocityY(value:Number):IPhysBodyObjectModel;
		function get velocityX():Number;
		function get velocityY():Number;
		function setRotation(value:Number):IPhysBodyObjectModel
		function setAllowRotation(value:Boolean):IPhysBodyObjectModel
		function putToSleep():IPhysBodyObjectModel
		function worldVectorToLocal(input:Vec2):Vec2;
	}
}
