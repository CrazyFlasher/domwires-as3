/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.mvc.model
{
	import com.crazyfm.mvc.event.ISignalEvent;
	import com.crazyfm.mvc.view.IViewController;

	/**
	 * Object tat is used for communication between model and view sides of application.
	 */
	public interface IContext extends IModelContainer
	{
//		function mapSignalTypeToCommand(signalType:String, commandClass:Class, toPool:Boolean = true):void;
//		function mapViewToMediator(view:IViewController, mediator:IController):void;
//		function unmapSignalTypeFromCommand(signalType:String, commandClass:Class):void;
//		function unmapViewFromMediator(view:IViewController, mediator:IController):void;

		/**
		 * Adds view to view list of current object.
		 * @param view
		 */
		function addView(view:IViewController):void;

		/**
		 * Adds several views to view list of current object.
		 * @param views
		 */
		function addViews(views:Vector.<IViewController>):void;

		/**
		 * Removes view from view list of current object.
		 * @param view
		 * @param dispose
		 */
		function removeView(view:IViewController, dispose:Boolean = false):void;

		/**
		 * Removes several views from view list of current object.
		 * @param views
		 * @param dispose If true, then removed views will ne disposed
		 */
		function removeViews(views:Vector.<IViewController>, dispose:Boolean = false):void;

		/**
		 * Removes all views from view list of current object.
		 * @param dispose If true, then removed views will ne disposed
		 */
		function removeAllViews(dispose:Boolean = false):void;

		/**
		 * Returns number of added views to model list of current object.
		 */
		function get numViews():int;

		/**
		 * Returns true if current object contains this view.
		 * @param view
		 * @return
		 */
		function containsView(view:IViewController):Boolean;

		/**
		 * Broadcasts any received from hierarchy signal to IViewController(s).
		 * @param event
		 */
		function dispatchSignalToViews(event:ISignalEvent):void;
	}
}
