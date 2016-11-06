/**
 * Created by CrazyFlasher on 6.11.2016.
 */
package com.domwires.core.mvc.hierarchy
{
	/**
	 * @see com.domwires.core.mvc.hierarchy.IHierarchyObjectContainer
	 */
	public interface IHierarchyObjectContainerImmutable extends IHierarchyObjectImmutable
	{
		/**
		 * Returns all children of current container.
		 */
		function get children():Array;
	}
}
