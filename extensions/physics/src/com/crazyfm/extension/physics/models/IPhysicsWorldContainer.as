/**
 * Created by Anton Nefjodov on 11.02.2016.
 */
package com.crazyfm.extension.physics.models
{
	import com.crazyfm.core.mvc.model.IModelContainer;

	/**
	 * Physics world container for simulation. Can contain body models, joint models and other stuff related to physics.
	 */
	public interface IPhysicsWorldContainer extends IModelContainer
	{
		/**
		 * Step simulation forward in time.
		 * @param deltaTime The number of milliseconds to simulate
		 * @param velocityIterations The number of iterations to use in resolving errors in the velocities of objects. This is together with collision detection the most expensive phase of a simulation update, as well as the most important for stable results.
		 * @param positionIterations The number of iterations to use in resolving errors in the positions of objects. This is far more lightweight than velocity iterations, as well as being less important for the stability of results.
		 */
		function step(deltaTime:uint, velocityIterations:uint = 10, positionIterations:uint = 10):void;
	}
}
