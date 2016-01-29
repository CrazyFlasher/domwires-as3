/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	public interface IModelContainer extends IModel
	{
		function addModel(model:IModel):void;
		function addModels(models:Vector.<IModel>):void;
		function removeModel(model:IModel, dispose:Boolean = false):void;
		function removeModels(models:Vector.<IModel>, dispose:Boolean = false):void;
		function removeAllModels(dispose:Boolean = false):void;
		function get numModels():int;
		function contains(model:IModel):Boolean;
		function disposeWithAllChildren():void;
	}
}
