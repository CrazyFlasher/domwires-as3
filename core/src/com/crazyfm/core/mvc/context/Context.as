/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainer;
	import com.crazyfm.core.mvc.hierarchy.ns_hierarchy;
	import com.crazyfm.core.mvc.model.*;
	import com.crazyfm.core.mvc.service.IService;
	import com.crazyfm.core.mvc.service.IServiceContainer;
	import com.crazyfm.core.mvc.service.ServiceContainer;
	import com.crazyfm.core.mvc.view.IView;
	import com.crazyfm.core.mvc.view.IViewContainer;
	import com.crazyfm.core.mvc.view.ViewContainer;

	import org.osflash.signals.events.IEvent;

	use namespace ns_hierarchy;

	public class Context extends HierarchyObjectContainer implements IContext
	{
		protected var modelContainer:IModelContainer;
		protected var viewContainer:IViewContainer;
		protected var serviceContainer:IServiceContainer;

		public function Context()
		{
			super();

			modelContainer = new ModelContainer();
			add(modelContainer);

			serviceContainer = new ServiceContainer();
			add(serviceContainer);

			viewContainer = new ViewContainer();
			add(viewContainer);
		}

		public function addModel(model:IModel):IModelContainer
		{
			return modelContainer.addModel(model);
		}

		public function removeModel(model:IModel, dispose:Boolean = false):IModelContainer
		{
			return modelContainer.removeModel(model, dispose);
		}

		public function removeAllModels(dispose:Boolean = false):IModelContainer
		{
			return modelContainer.removeAllModels(dispose);
		}

		public function get numModels():int
		{
			return modelContainer.numModels;
		}

		public function containsModel(model:IModel):Boolean
		{
			return modelContainer.containsModel(model);
		}

		public function get modelList():Array
		{
			return modelContainer.modelList;
		}

		public function dispatchSignalToModels(type:Enum, data:Object = null):void
		{
			modelContainer.dispatchSignalToModels(type, data);
		}

		public function addView(view:IView):IViewContainer
		{
			return viewContainer.addView(view);
		}

		public function removeView(view:IView, dispose:Boolean = false):IViewContainer
		{
			return viewContainer.removeView(view, dispose);
		}

		public function removeAllViews(dispose:Boolean = false):IViewContainer
		{
			return viewContainer.removeAllViews(dispose);
		}

		public function get numViews():int
		{
			return viewContainer.numViews;
		}

		public function containsView(view:IView):Boolean
		{
			return viewContainer.containsView(view);
		}

		public function get viewList():Array
		{
			return viewContainer.viewList;
		}

		public function dispatchSignalToViews(type:Enum, data:Object = null):void
		{
			viewContainer.dispatchSignalToViews(type, data);
		}

		public function addService(service:IService):IServiceContainer
		{
			return serviceContainer.addService(service);
		}

		public function removeService(service:IService, dispose:Boolean = false):IServiceContainer
		{
			return serviceContainer.removeService(service, dispose);
		}

		public function removeAllServices(dispose:Boolean = false):IServiceContainer
		{
			return serviceContainer.removeAllServices(dispose);
		}

		public function get numServices():int
		{
			return serviceContainer.numServices;
		}

		public function containsService(service:IService):Boolean
		{
			return serviceContainer.containsService(service);
		}

		public function get serviceList():Array
		{
			return serviceContainer.serviceList;
		}

		public function dispatchSignalToServices(type:Enum, data:Object = null):void
		{
			serviceContainer.dispatchSignalToServices(type, data);
		}

		override public function dispose():void
		{
			modelContainer.dispose();
			viewContainer.dispose();
			serviceContainer.dispose();

			modelContainer = null;
			viewContainer = null;
			serviceContainer = null;

			super.dispose();
		}

		override public function disposeWithAllChildren():void
		{
			modelContainer.disposeWithAllChildren();
			viewContainer.disposeWithAllChildren();
			serviceContainer.disposeWithAllChildren();

			modelContainer = null;
			viewContainer = null;
			serviceContainer = null;

			super.disposeWithAllChildren();
		}

		override public function onEventBubbled(event:IEvent):Boolean
		{
			var e:ISignalEvent = event as ISignalEvent;

			if (event.target is IModel)
			{
				dispatchSignalToViews(e.type, e.data);
				dispatchSignalToServices(e.type, e.data);
			}else
			if (event.target is IService)
			{
				dispatchSignalToViews(e.type, e.data);
				dispatchSignalToModels(e.type, e.data);
			}else
			if (event.target is IView)
			{
				dispatchSignalToServices(e.type, e.data);
				dispatchSignalToModels(e.type, e.data);
			}

			return super.onEventBubbled(event);
		}

	}
}
