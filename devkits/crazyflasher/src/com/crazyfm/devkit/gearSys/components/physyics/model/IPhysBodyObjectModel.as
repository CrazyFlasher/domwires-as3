/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.gearSys.components.physyics.model
{
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Shape;

	PhysBodyObjectModel;
	public interface IPhysBodyObjectModel extends IGearSysComponent
	{
		function onBodyBeginCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void;
		function onBodyEndCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void;
		function onBodyOnGoingCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void;
		function onBodyPreCollision(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void;

		function onBodyBeginSensor(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void;
		function onBodyEndSensor(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void;
		function onBodyOnGoingSensor(collision:InteractionCallback, otherBody:Body, otherShape:Shape):void;

		function get position():Vec2;
		function get velocity():Vec2;
		function get rotation():Number;
		function set rotation(value:Number):void;
		function get localCenterOfMass():Vec2;
		function get worldCenterOfMass():Vec2;
	}
}
