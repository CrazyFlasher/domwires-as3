/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObject;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;
	import com.crazyfm.core.mvc.hierarchy.ns_hierarchy;
	import com.crazyfm.core.mvc.model.*;
	import com.crazyfm.core.mvc.view.IViewController;

	import org.osflash.signals.events.IEvent;

	use namespace ns_hierarchy;

	/**
	 * Extends IModelContainer and is able to communicate with IViewController objects via signals and/or direct connection
	 * (interface methods calls). Re-dispatches received from model hierarchy signals to IViewControllers, that are connected to current
	 * IContext.
	 */
	public class Context extends ModelContainer implements IContext
	{
		protected var _viewList:Array = [];

		public function Context()
		{
			super();
		}

		 /**
		 * @inheritDoc
		 */
		public function addViewController(viewController:IViewController):IContext
		{
			add(viewController, _viewList);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeViewController(viewController:IViewController, dispose:Boolean = false):IContext
		{
			remove(viewController, _viewList);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllViewControllers(dispose:Boolean = false):IContext
		{
			removeAll(dispose, _viewList);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numViewControllers():int
		{
			return _viewList != null ? _viewList.length : 0;
		}

		/**
		 * @inheritDoc
		 */
		public function containsViewController(viewController:IViewController):Boolean
		{
			return _viewList != null ? _viewList.indexOf(viewController) != -1 : false;
		}

		/**
		 * Disposes current object and disposes models from its model list and views from view list.
		 */
		override public function disposeWithAllChildren():void
		{
			removeAllViewControllers(true);

			super.disposeWithAllChildren();
		}

		/**
		 * Disposes object and removes all children models and views, but doesn't dispose them.
		 */
		override public function dispose():void
		{
			removeAllViewControllers();

			super.dispose();
		}

		/**
		 * @inheritDoc
		 * Broadcasts received from hierarchy signal.
		 */
		public function dispatchSignalToViewControllers(event:ISignalEvent):void
		{
			dispatchSignalToChildren(event.type, event.data, _viewList);
		}

		/**
		 * Handler for event bubbling.
		 * Dispatches bubbled event to IViewControllers.
		 * @param    event The event that bubbled up.
		 * @return whether to continue bubbling this event
		 */
		override public function onEventBubbled(event:IEvent):Boolean
		{
			if (!(event.target is IViewController))
			{
				dispatchSignalToViewControllers(event as ISignalEvent);
			}

			return super.onEventBubbled(event);
		}

		/**
		 * @inheritDoc
		 */
		public function get viewControllerList():Array
		{
			return _viewList;
		}

		override public function remove(child:IHierarchyObject, dispose:Boolean = false, fromList:Array = null):IHierarchyObjectContainer
		{
			if (child is IViewController)
			{
				super.remove(child, dispose, _viewList);
			}

			return this;
		}
	}
}
