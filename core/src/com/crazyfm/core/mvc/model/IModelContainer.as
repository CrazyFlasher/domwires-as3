/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.model
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IModelContainer extends IModel, IHierarchyObjectContainer
	{
		function addModel(model:IModel):IModelContainer;

		function removeModel(model:IModel, dispose:Boolean = false):IModelContainer;

		function removeAllModels(dispose:Boolean = false):IModelContainer;

		function get numModels():int;

		function containsModel(model:IModel):Boolean;

		function get modelList():Array;

		function dispatchSignalToModels(type:Enum, data:Object = null):void;
	}
}
