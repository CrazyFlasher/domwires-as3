/**
 * Created by CrazyFlasher on 6.11.2016.
 */
package com.domwires.core.mvc.view
{
	import com.domwires.core.mvc.hierarchy.IHierarchyObjectContainerImmutable;

	/**
	 * @see com.domwires.core.mvc.view.IViewContainer
	 */
	public interface IViewContainerImmutable extends IHierarchyObjectContainerImmutable
	{
		/**
		 * Returns number of views in current container.
		 */
		function get numViews():int;

		/**
		 * Returns true, if current container has provided view.
		 * @param view
		 * @return
		 */
		function containsView(view:IViewImmutable):Boolean;

		/**
		 * Returns list of views in current container.
		 */
		function get viewList():Array;
	}
}
