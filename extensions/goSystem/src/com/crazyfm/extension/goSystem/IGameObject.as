/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IContext;

	import starling.animation.IAnimatable;

	public interface IGameObject extends IContext, IAnimatable
	{
		function stopSimulation():void;
		function startSimulation():void;
		function get isSimulating():Boolean;
	}
}
