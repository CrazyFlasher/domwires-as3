/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.domwires.core.mvc.view
{
	import com.domwires.core.mvc.hierarchy.HierarchyObjectContainer;

	/**
	 * Container for views.
	 */
	public class ViewContainer extends HierarchyObjectContainer implements IViewContainer
	{
		/**
		 * @inheritDoc
		 */
		public function addView(view:IView):IViewContainer
		{
			add(view);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeView(view:IView, dispose:Boolean = false):IViewContainer
		{
			remove(view, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllViews(dispose:Boolean = false):IViewContainer
		{
			removeAll(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numViews():int
		{
			return children ? children.length : 0;
		}

		/**
		 * @inheritDoc
		 */
		public function containsView(view:IViewImmutable):Boolean
		{
			return contains(view);
		}

		/**
		 * @inheritDoc
		 */
		public function get viewList():Array
		{
			return children;
		}
	}
}
