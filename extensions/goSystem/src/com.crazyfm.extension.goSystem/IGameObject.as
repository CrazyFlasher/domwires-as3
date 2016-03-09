/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModelContainer;

	public interface IGameObject extends IModelContainer
	{
		function addComponent(value:IComponent):void;
		function addComponents(...values):void;
		function removeComponent(value:IComponent):void;
		function removeComponents(...values):void;
		function removeAllComponents():void;
	}
}
