/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.view
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IViewContainer extends IView, IHierarchyObjectContainer
	{
		function addView(view:IView):IViewContainer;

		function removeView(view:IView, dispose:Boolean = false):IViewContainer;

		function removeAllViews(dispose:Boolean = false):IViewContainer;

		function get numViews():int;

		function containsView(view:IView):Boolean;

		function get viewList():Array;

		function dispatchSignalToViews(type:Enum, data:Object = null):void;
	}
}
