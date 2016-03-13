/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.model
{
	import flash.utils.Dictionary;

	/**
	 * Extends IModel and is able to add or remove other IModel objects (can be parent of them). Also receives all
	 * signals from children, sub-children and so on.
	 */
	public interface IModelContainer extends IModel
	{
		/**
		 * Adds model to model list of current object.
		 * @param model
		 */
		function addModel(model:IModel):IModelContainer;

		/**
		 * Removes model from model list of current object.
		 * @param model
		 * @param dispose
		 */
		function removeModel(model:IModel, dispose:Boolean = false):IModelContainer;

		/**
		 * Removes all models from model list of current object.
		 * @param dispose If true, then removed models will ne disposed
		 */
		function removeAllModels(dispose:Boolean = false):IModelContainer;

		/**
		 * Returns number of added models to model list of current object.
		 */
		function get numModels():int;

		/**
		 * Returns true if current object contains this model.
		 * @param model
		 * @return true, if object contains current model
		 */
		function containsModel(model:IModel):Boolean;

		/**
		 * Disposes current object and disposes objects from its model list.
		 */
		function disposeWithAllChildren():void;

		/**
		 * Returns children models.
		 */
		function get modelList():Dictionary;

		/**
		 * Dispatches signal down to hierarchy.
		 * @param type Signal type/name/id
		 * @param data Optional data that will sent with signal
		 */
		function dispatchSignalToChildren(type:String, data:Object = null):void;
	}
}
