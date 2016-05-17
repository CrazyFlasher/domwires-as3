/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.model
{
	import nape.geom.AABB;

	public interface IInteractivePhysObjectModel extends IPhysBodyObjectModel
	{
		function get isOnLegs():Boolean;
		function setZeroGravity(value:Boolean):IInteractivePhysObjectModel;
		function get zeroGravity():Boolean;
		function get bounds():AABB;
		function teleportTo(x:Number, y:Number, time:int = 0):IInteractivePhysObjectModel;
		function get isTeleporting():Boolean;
	}
}
