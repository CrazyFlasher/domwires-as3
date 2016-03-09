/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModelContainer;

	import flash.utils.Dictionary;

	public interface IGameObject extends IModelContainer
	{
		function addComponent(value:IComponent):void;
		function addComponents(...values):void;
		function removeComponent(value:IComponent):void;
		function removeComponents(...values):void;
		function removeAllComponents():void;
		function get numComponents():int;
		function get componentList():Dictionary;
	}
}
