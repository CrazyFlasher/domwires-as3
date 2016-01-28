/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	public interface IModelContainer extends IModel
	{
		function addModel(model:IModel):void;
		function removeModel(model:IModel):void;
		function removeAllModels():void;
	}
}
