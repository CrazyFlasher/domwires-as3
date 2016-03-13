/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModel;

	import starling.animation.IAnimatable;

	public interface IGameComponent extends IModel, IAnimatable
	{
		function get gameObject():IGameObject;
	}
}
