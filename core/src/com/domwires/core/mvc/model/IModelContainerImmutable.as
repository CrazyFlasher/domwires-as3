/**
 * Created by CrazyFlasher on 6.11.2016.
 */
package com.domwires.core.mvc.model
{
	import com.domwires.core.mvc.hierarchy.IHierarchyObjectContainerImmutable;

	/**
	 * @see com.domwires.core.mvc.model.IModelContainer
	 */
	public interface IModelContainerImmutable extends IModelImmutable, IHierarchyObjectContainerImmutable
	{
		/**
		 * Returns number of models in current container.
		 */
		function get numModels():int;

		/**
		 * Returns true, if current container has provided model.
		 * @param model
		 * @return
		 */
		function containsModel(model:IModel):Boolean;

		/**
		 * Returns list of models in current container.
		 */
		function get modelList():Array;
	}
}
