/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.model
{
	import com.crazy.mvc.view.IView;

	/**
	 * Object tat is used for communication between model and view sides of application
	 */
	public interface IContext extends IModelContainer
	{
		function mapSignalTypeToCommand(signalType:String, commandClass:Class, toPool:Boolean = true):void;
		//function mapViewToMediator(view:IView, mediator:IController):void;
		function unmapSignalTypeFromCommand(signalType:String, commandClass:Class):void;
		//function unmapViewFromMediator(view:IView, mediator:IController):void;

		/**
		 * Adds view to view list of current object
		 * @param view
		 */
		function addView(view:IView):void;

		/**
		 * Adds several views to view list of current object
		 * @param views
		 */
		function addViews(views:Vector.<IView>):void;

		/**
		 * Removes view from view list of current object
		 * @param view
		 * @param dispose
		 */
		function removeView(view:IView, dispose:Boolean = false):void;

		/**
		 * Removes several views from view list of current object
		 * @param views
		 * @param dispose If true, then removed views will ne disposed
		 */
		function removeViews(views:Vector.<IView>, dispose:Boolean = false):void;

		/**
		 * Removes all views from view list of current object
		 * @param dispose If true, then removed views will ne disposed
		 */
		function removeAllViews(dispose:Boolean = false):void;

		/**
		 * Returns number of added views to model list of current object
		 */
		function get numViews():int;

		/**
		 * Returns true if current object contains this view
		 * @param view
		 * @return
		 */
		function containsView(view:IView):Boolean;
	}
}
