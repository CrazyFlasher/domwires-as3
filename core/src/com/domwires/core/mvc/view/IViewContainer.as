/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.domwires.core.mvc.view
{
	import com.domwires.core.mvc.hierarchy.IHierarchyObjectContainer;

	/**
	 * Container for views.
	 */
	ViewContainer;
	public interface IViewContainer extends IViewContainerImmutable, IView, IHierarchyObjectContainer
	{
		/**
		 * Adds view to current container.
		 * @param view
		 * @return
		 */
		function addView(view:IView):IViewContainer;

		/**
		 * Removes view from current container.
		 * @param view
		 * @param dispose
		 * @return
		 */
		function removeView(view:IView, dispose:Boolean = false):IViewContainer;

		/**
		 * Removes all views from current container.
		 * @param dispose
		 * @return
		 */
		function removeAllViews(dispose:Boolean = false):IViewContainer;
	}
}
