/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.domwires.core.mvc.model
{
	import com.domwires.core.mvc.hierarchy.IHierarchyObjectContainer;

	/**
	 * Container for models.
	 */
	ModelContainer;
	public interface IModelContainer extends IModelContainerImmutable, IModel, IHierarchyObjectContainer
	{
		/**
		 * Adds model to current container.
		 * @param model
		 * @return
		 */
		function addModel(model:IModel):IModelContainer;

		/**
		 * Removes model from current container.
		 * @param model
		 * @param dispose
		 * @return
		 */
		function removeModel(model:IModel, dispose:Boolean = false):IModelContainer;

		/**
		 * Removes all models from current container.
		 * @param dispose
		 * @return
		 */
		function removeAllModels(dispose:Boolean = false):IModelContainer;
	}
}
