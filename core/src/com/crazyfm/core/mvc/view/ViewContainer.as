/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.view
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainer;

	import flash.display.DisplayObjectContainer;

	public class ViewContainer extends HierarchyObjectContainer implements IViewContainer
	{
		protected var container:DisplayObjectContainer;

		public function ViewContainer(container:DisplayObjectContainer)
		{
			super();

			this.container = container;
		}

		public function addView(view:IView):IViewContainer
		{
			return this;
		}

		public function removeView(view:IView, dispose:Boolean = false):IViewContainer
		{
			remove(view, dispose);

			return this;
		}

		public function removeAllViews(dispose:Boolean = false):IViewContainer
		{
			removeAll(dispose);

			return this;
		}

		public function get numViews():int
		{
			return _childrenList ? _childrenList.length : 0;
		}

		public function containsView(view:IView):Boolean
		{
			return _childrenList && _childrenList.indexOf(view) != -1;
		}

		public function get viewList():Array
		{
			return _childrenList;
		}

		public function dispatchSignalToViews(type:Enum, data:Object = null):void
		{
			dispatchSignalToChildren(type, data);
		}

		override public function dispose():void
		{
			container = null;

			super.dispose();
		}

		override public function disposeWithAllChildren():void
		{
			container = null;

			super.disposeWithAllChildren();
		}
	}
}
