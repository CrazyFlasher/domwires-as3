/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.model
{
	/**
	 * Model object that can contain other models.
	 */
	public interface IModelContainer extends IModel
	{
		/**
		 * Adds model to model list of current object.
		 * @param model
		 */
		function addModel(model:IModel):void;

		/**
		 * Adds several model to model list of current object.
		 * @param models
		 */
		function addModels(models:Vector.<IModel>):void;

		/**
		 * Removes model from model list of current object.
		 * @param model
		 * @param dispose
		 */
		function removeModel(model:IModel, dispose:Boolean = false):void;

		/**
		 * Removes several model from model list of current object.
		 * @param models
		 * @param dispose If true, then removed models will ne disposed
		 */
		function removeModels(models:Vector.<IModel>, dispose:Boolean = false):void;

		/**
		 * Removes all models from model list of current object.
		 * @param dispose If true, then removed models will ne disposed
		 */
		function removeAllModels(dispose:Boolean = false):void;

		/**
		 * Returns number of added models to model list of current object.
		 */
		function get numModels():int;

		/**
		 * Returns true if current object contains this model.
		 * @param model
		 * @return
		 */
		function containsModel(model:IModel):Boolean;

		/**
		 * Disposes current object and disposes objects from its model list.
		 */
		function disposeWithAllChildren():void;
	}
}
