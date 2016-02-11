/**
 * Created by Anton Nefjodov on 11.02.2016.
 */
package com.crazyfm.extension.physics.models
{
	import com.crazyfm.core.mvc.model.IContext;

	/**
	 * Physics object context, that may have direct communication with IPhysicsViewObjectController.
	 */
	public interface IPhysicsObjectContext extends IContext
	{
		/**
		 * /**
		 * Step simulation forward in time.
		 * @param deltaTime The number of milliseconds to simulate
		 */
		function step(deltaTime:uint):void;

		function set x(value:Number):void;

		function set y(value:Number):void;

		function get x():Number;

		function get y():Number;

		function set velocityX(value:Number):void;

		function set velocityY(value:Number):void;

		function get velocityY():Number;

		function get velocityX():Number;
	}
}
