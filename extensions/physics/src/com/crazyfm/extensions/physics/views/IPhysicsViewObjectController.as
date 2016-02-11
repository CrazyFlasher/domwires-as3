/**
 * Created by Anton Nefjodov on 11.02.2016.
 */
package com.crazyfm.extensions.physics.views
{
	import com.crazyfm.core.mvc.view.IViewController;

	/**
	 * Visual object controller, that may have direct communication with IPhysicsObjectContext.
	 */
	public interface IPhysicsViewObjectController extends IViewController
	{
		function set degreeRotation(value:Number):void;

		function get degreeRotation():Number;

		function set x(value:Number):void;

		function set y(value:Number):void;

		function get x():Number;

		function get y():Number;
	}
}
