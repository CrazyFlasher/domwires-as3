/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.model
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.view.IViewController;

	import flash.utils.Dictionary;

	/**
	 * Extends IModelContainer and is able to communicate with IViewController objects via signals and/or direct connection
	 * (interface methods calls). Re-dispatches received from model hierarchy signals to IViewControllers, that are connected to current
	 * IContext.
	 */
	public interface IContext extends IModelContainer
	{
		/**
		 * Adds IViewController to view controller list of current object.
		 * @param viewController
		 */
		function addViewController(viewController:IViewController):void;

		/**
		 * Adds several IViewControllers to view controller list of current object.
		 * @param viewControllers
		 */
		function addViewControllers(...viewControllers):void;

		/**
		 * Removes IViewController from view controller list of current object.
		 * @param viewController
		 * @param dispose
		 */
		function removeViewController(viewController:IViewController, dispose:Boolean = false):void;

		/**
		 * Removes several IViewControllers from view controller list of current object.
		 * @param dispose If true, then removed IViewControllers will be disposed
		 * @param viewControllers
		 */
		function removeViewControllers(dispose:Boolean, ...viewControllers):void;

		/**
		 * Removes all IViewControllers from view controller list of current object.
		 * @param dispose If true, then removed IViewControllers will ne disposed
		 */
		function removeAllViewControllers(dispose:Boolean = false):void;

		/**
		 * Returns number of added IViewControllers to model list of current object.
		 */
		function get numViewControllers():int;

		/**
		 * Returns true if current object contains this IViewController.
		 * @param viewController
		 * @return
		 */
		function containsViewController(viewController:IViewController):Boolean;

		/**
		 * Broadcasts any received from hierarchy signal to IViewControllers.
		 * @param event
		 */
		function dispatchSignalToViewControllers(event:ISignalEvent):void;
	}
}
