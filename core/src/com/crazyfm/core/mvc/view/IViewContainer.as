/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.view
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	/**
	 * Container for views.
	 */
	public interface IViewContainer extends IView, IHierarchyObjectContainer
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

		/**
		 * Returns number of views in current container.
		 */
		function get numViews():int;

		/**
		 * Returns true, if current container has provided view.
		 * @param view
		 * @return
		 */
		function containsView(view:IView):Boolean;

		/**
		 * Returns list of views in current container.
		 */
		function get viewList():Array;

		/**
		 * Sends signal to children views.
		 * @param type
		 * @param data
		 */
		function dispatchSignalToViews(type:Enum, data:Object = null):void;
	}
}
