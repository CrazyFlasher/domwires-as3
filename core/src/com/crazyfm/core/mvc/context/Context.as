/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.hierarchy.HierarchyObject;
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

		private var commandMapper:ICommandMapper;

		public function Context(factory:AppFactory = null)
		{
			super();

			if (factory == null)
			{
				log("Warning: factory is not specified. Using singleton...");
				factory = AppFactory.getSingletonInstance();
			}

			modelContainer = factory.getInstance(ModelContainer);
			add(modelContainer);

			serviceContainer = factory.getInstance(ServiceContainer);
			add(serviceContainer);

			viewContainer = factory.getInstance(ViewContainer);
			add(viewContainer);

			commandMapper = factory.getInstance(CommandMapper, factory);
		}

		public function addModel(model:IModel):IModelContainer
		{
			modelContainer.addModel(model);
			(model as HierarchyObject).setParent(this);

			return this;
		}

		public function removeModel(model:IModel, dispose:Boolean = false):IModelContainer
		{
			modelContainer.removeModel(model, dispose);

			return this;
		}

		public function removeAllModels(dispose:Boolean = false):IModelContainer
		{
			modelContainer.removeAllModels(dispose);

			return this;
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
			viewContainer.addView(view);
			(view as HierarchyObject).setParent(this);

			return this;
		}

		public function removeView(view:IView, dispose:Boolean = false):IViewContainer
		{
			viewContainer.removeView(view, dispose);

			return this;
		}

		public function removeAllViews(dispose:Boolean = false):IViewContainer
		{
			viewContainer.removeAllViews(dispose);

			return this;
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
			serviceContainer.addService(service);
			(service as HierarchyObject).setParent(this);

			return this;
		}

		public function removeService(service:IService, dispose:Boolean = false):IServiceContainer
		{
			serviceContainer.removeService(service, dispose);

			return this;
		}

		public function removeAllServices(dispose:Boolean = false):IServiceContainer
		{
			serviceContainer.removeAllServices(dispose);

			return this;
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

			nullifyDependencies();

			super.dispose();
		}

		private function nullifyDependencies():void
		{
			modelContainer = null;
			viewContainer = null;
			serviceContainer = null;

			commandMapper.dispose();
			commandMapper = null;
		}

		override public function disposeWithAllChildren():void
		{
			modelContainer.disposeWithAllChildren();
			viewContainer.disposeWithAllChildren();
			serviceContainer.disposeWithAllChildren();

			nullifyDependencies();

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

			commandMapper.dispatchSignal(e.type, e.data, e.bubbles);

			return super.onEventBubbled(event);
		}

		public function map(signalType:Enum, commandClass:Class):ICommandMapper
		{
			return commandMapper.map(signalType, commandClass);
		}

		public function unmap(signalType:Enum, commandClass:Class):ICommandMapper
		{
			return commandMapper.unmap(signalType, commandClass);
		}

		public function clear():ICommandMapper
		{
			return commandMapper.clear();
		}

		public function unmapAll(signalType:Enum):ICommandMapper
		{
			return commandMapper.unmapAll(signalType);
		}

		public function hasMapping(signalType:Enum):Boolean
		{
			return commandMapper.hasMapping(signalType);
		}
	}
}
