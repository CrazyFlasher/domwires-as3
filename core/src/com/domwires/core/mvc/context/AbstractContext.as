/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.domwires.core.mvc.context
{
	import com.domwires.core.common.Enum;
	import com.domwires.core.factory.IAppFactory;
	import com.domwires.core.mvc.command.CommandMapper;
	import com.domwires.core.mvc.command.ICommandMapper;
	import com.domwires.core.mvc.command.MappingConfig;
	import com.domwires.core.mvc.command.MappingConfigList;
	import com.domwires.core.mvc.context.config.ContextConfigVo;
	import com.domwires.core.mvc.context.config.ContextConfigVoBuilder;
	import com.domwires.core.mvc.hierarchy.AbstractHierarchyObject;
	import com.domwires.core.mvc.hierarchy.HierarchyObjectContainer;
	import com.domwires.core.mvc.hierarchy.ns_hierarchy;
	import com.domwires.core.mvc.message.IMessage;
	import com.domwires.core.mvc.model.IModel;
	import com.domwires.core.mvc.model.IModelContainer;
	import com.domwires.core.mvc.model.IModelImmutable;
	import com.domwires.core.mvc.model.ModelContainer;
	import com.domwires.core.mvc.view.IView;
	import com.domwires.core.mvc.view.IViewContainer;
	import com.domwires.core.mvc.view.IViewImmutable;
	import com.domwires.core.mvc.view.ViewContainer;

	use namespace ns_hierarchy;

	/**
	 * Context contains models, views and services. Also implements <code>ICommandMapper</code>. You can map specific messages, that came out
	 * from hierarchy, to <code>ICommand</code>s.
	 */
	public class AbstractContext extends HierarchyObjectContainer implements IContextImmutable, IContext
	{

		/**
		 * <b>[Autowired]</b>
		 */
		[Autowired]
		public var factory:IAppFactory;

		/**
		 * <b>[Autowired(optional="true")]</b>
		 */
		[Autowired(optional="true")]
		public var config:ContextConfigVo;

		private var constructorConfig:ContextConfigVo;

		private var modelContainer:IModelContainer;
		private var viewContainer:IViewContainer;

		private var commandMapper:ICommandMapper;

		public function AbstractContext(config:ContextConfigVo = null)
		{
			super();

			constructorConfig = config;
		}

		[PostConstruct]
		public function init():void
		{
			if (!config)
			{
				if (!constructorConfig)
				{
					config = new ContextConfigVoBuilder().build();
				}else
				{
					config = constructorConfig;
				}
			}

			factory.mapToValue(IAppFactory, factory);

			modelContainer = factory.getInstance(ModelContainer);
			add(modelContainer);

			viewContainer = factory.getInstance(ViewContainer);
			add(viewContainer);

			commandMapper = factory.getInstance(CommandMapper);
		}

		/**
		 * @inheritDoc
		 */
		public function addModel(model:IModel):IModelContainer
		{
			checkIfDisposed();

			modelContainer.addModel(model);
			(model as AbstractHierarchyObject).setParent(this);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeModel(model:IModel, dispose:Boolean = false):IModelContainer
		{
			checkIfDisposed();

			modelContainer.removeModel(model, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllModels(dispose:Boolean = false):IModelContainer
		{
			checkIfDisposed();

			modelContainer.removeAllModels(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numModels():int
		{
			checkIfDisposed();

			return modelContainer.numModels;
		}

		/**
		 * @inheritDoc
		 */
		public function containsModel(model:IModelImmutable):Boolean
		{
			checkIfDisposed();

			return modelContainer.containsModel(model);
		}

		/**
		 * @inheritDoc
		 */
		public function get modelList():Array
		{
			checkIfDisposed();

			return modelContainer.modelList;
		}

		/**
		 * @inheritDoc
		 */
		public function addView(view:IView):IViewContainer
		{
			checkIfDisposed();

			viewContainer.addView(view);
			(view as AbstractHierarchyObject).setParent(this);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeView(view:IView, dispose:Boolean = false):IViewContainer
		{
			checkIfDisposed();

			viewContainer.removeView(view, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllViews(dispose:Boolean = false):IViewContainer
		{
			checkIfDisposed();

			viewContainer.removeAllViews(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numViews():int
		{
			checkIfDisposed();

			return viewContainer.numViews;
		}

		/**
		 * @inheritDoc
		 */
		public function containsView(view:IViewImmutable):Boolean
		{
			checkIfDisposed();

			return viewContainer.containsView(view);
		}

		/**
		 * @inheritDoc
		 */
		public function get viewList():Array
		{
			checkIfDisposed();

			return viewContainer.viewList;
		}

		/**
		 * Clears all children, unmaps all commands and nullifies dependencies.
		 */
		override public function dispose():void
		{
			modelContainer.dispose();
			viewContainer.dispose();
			commandMapper.dispose();

			nullifyDependencies();

			super.dispose();
		}

		private function nullifyDependencies():void
		{
			modelContainer = null;
			viewContainer = null;
			commandMapper = null;
		}

		/**
		 * Disposes all children, unmaps all commands and nullifies dependencies.
		 */
		override public function disposeWithAllChildren():void
		{
			commandMapper.dispose();

			nullifyDependencies();

			super.disposeWithAllChildren();
		}

		/**
		 * By default, messaged won't bubble up to higher hierarchy level.
		 * Override and return true, if you want bubbled message move higher.
		 * @see com.domwires.core.mvc.message.IBubbleMessageHandler#onMessageBubbled
		 */
		override public function onMessageBubbled(message:IMessage):Boolean
		{
			super.onMessageBubbled(message);

			return false;
		}

		/**
		 * Handle specified message and send it to context children according context config
		 * @see #com.domwires.core.mvc.context.config.ContextConfigVo
		 * @param message
		 */
		override public function handleMessage(message:IMessage):void
		{
			super.handleMessage(message);

			tryToExecuteCommand(message);

			if (message.target is IModel)
			{
				if (config.forwardMessageFromModelsToModels)
				{
					dispatchMessageToModels(message);
				}
				if (config.forwardMessageFromModelsToViews)
				{
					dispatchMessageToViews(message);
				}
			}else
			if (message.target is IView)
			{
				if (config.forwardMessageFromViewsToModels)
				{
					dispatchMessageToModels(message);
				}
				if (config.forwardMessageFromViewsToViews)
				{
					dispatchMessageToViews(message);
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function dispatchMessageToChildren(message:IMessage):void
		{
			super.dispatchMessageToChildren(message);

			tryToExecuteCommand(message);
		}

		/**
		 * @inheritDoc
		 */
		public function map(messageType:Enum, commandClass:Class, data:Object = null, once:Boolean = false, stopOnExecute:Boolean = false):MappingConfig
		{
			checkIfDisposed();

			return commandMapper.map(messageType, commandClass, data, once, stopOnExecute);
		}

		public function map1(messageType:Enum, commandClassList:Vector.<Class>, data:Object = null,
							 once:Boolean = false, stopOnExecute:Boolean = false):MappingConfigList
		{
			checkIfDisposed();

			return commandMapper.map1(messageType, commandClassList, data, once, stopOnExecute);
		}

		public function map2(messageTypeList:Vector.<Enum>, commandClass:Class,
							 data:Object = null, once:Boolean = false, stopOnExecute:Boolean = false):MappingConfigList
		{
			checkIfDisposed();

			return commandMapper.map2(messageTypeList, commandClass, data, once, stopOnExecute);
		}

		public function map3(messageTypeList:Vector.<Enum>, commandClassList:Vector.<Class>,
							 data:Object = null, once:Boolean = false, stopOnExecute:Boolean = false):MappingConfigList
		{
			checkIfDisposed();

			return commandMapper.map3(messageTypeList, commandClassList, data, once, stopOnExecute);
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(messageType:Enum, commandClass:Class):ICommandMapper
		{
			checkIfDisposed();

			return commandMapper.unmap(messageType, commandClass);
		}

		/**
		 * @inheritDoc
		 */
		public function clear():ICommandMapper
		{
			checkIfDisposed();

			return commandMapper.clear();
		}

		/**
		 * @inheritDoc
		 */
		public function unmapAll(messageType:Enum):ICommandMapper
		{
			checkIfDisposed();

			return commandMapper.unmapAll(messageType);
		}

		/**
		 * @inheritDoc
		 */
		public function hasMapping(messageType:Enum):Boolean
		{
			checkIfDisposed();

			return commandMapper.hasMapping(messageType);
		}

		/**
		 * @inheritDoc
		 */
		public function tryToExecuteCommand(message:IMessage):void
		{
			checkIfDisposed();

			commandMapper.tryToExecuteCommand(message);
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchMessageToViews(message:IMessage):void
		{
			checkIfDisposed();

			viewContainer.dispatchMessageToChildren(message);
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchMessageToModels(message:IMessage):void
		{
			checkIfDisposed();

			modelContainer.dispatchMessageToChildren(message);
		}

		/**
		 * @inheritDoc
		 */
		public function executeCommand(commandClass:Class, data:Object = null):void
		{
			checkIfDisposed();

			commandMapper.executeCommand(commandClass, data);
		}

		private function checkIfDisposed():void
		{
			if (isDisposed)
			{
				throw new Error("Context already disposed!");
			}
		}
	}
}
