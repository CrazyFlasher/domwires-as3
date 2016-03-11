/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.model
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.view.IViewController;
	import com.crazyfm.core.mvc.view.ViewController;

	import flash.utils.Dictionary;

	import org.osflash.signals.events.IEvent;

	use namespace ns_hierarchy;

	/**
	 * Extends IModelContainer and is able to communicate with IViewController objects via signals and/or direct connection
	 * (interface methods calls). Re-dispatches received from model hierarchy signals to IViewControllers, that are connected to current
	 * IContext.
	 */
	public class Context extends ModelContainer implements IContext
	{
//		private var _injector:Injector;
//		private var _signalTypeToCommandMappings:Vector.<MappingVo>;

		protected var _viewList:Dictionary/*IViewController, IViewController*/

		private var _numViewControllers:int;

		public function Context()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		/*public function mapSignalTypeToCommand(signalType:String, commandClass:Class, toPool:Boolean = true):void
		 {
		 if (!_injector)
		 {
		 _injector = new Injector();
		 }

		 var command:ICommand = _injector.getOrCreateNewInstance(commandClass) as ICommand;

		 if (!_signalTypeToCommandMappings)
		 {
		 _signalTypeToCommandMappings = new <MappingVo>[];
		 }

		 if (containsSignalToCommandMapping(signalType, commandClass))
		 {
		 _signalTypeToCommandMappings.push(new MappingVo(signalType, command));
		 }
		 }

		 /**
		 * Returns true, if current object contains specified signal-to-command mapping
		 * @param signalType
		 * @param command
		 * @return
		 */
		/*public function containsSignalToCommandMapping(signalType:String, commandClass:Class):Boolean
		 {
		 if (!_signalTypeToCommandMappings) return false;

		 for each (var vo:MappingVo in _signalTypeToCommandMappings)
		 {
		 if (vo.signalType == signalType && vo.command is commandClass)
		 {
		 return true;
		 }
		 }

		 return false;
		 }

		 /**
		 * @inheritDoc
		 */
		/*public function unmapSignalTypeFromCommand(signalType:String, commandClass:Class):void
		 {
		 if (_signalTypeToCommandMappings)
		 {
		 var indexToRemove:int = -1;
		 for (var i:int = 0; i < _signalTypeToCommandMappings.length; i++)
		 {
		 var mapping:MappingVo = _signalTypeToCommandMappings[i];
		 if (mapping.signalType == signalType && mapping.command is commandClass)
		 {
		 indexToRemove = i;
		 mapping.dispose();
		 break;
		 }
		 }

		 if (indexToRemove > -1)
		 {
		 _signalTypeToCommandMappings.removeAt(indexToRemove);
		 }
		 }
		 }

		 /*public function mapViewToMediator(view:IViewController, mediator:IController):void
		 {

		 }

		 public function unmapViewFromMediator(view:IViewController, mediator:IController):void
		 {

		 }*/

		/**
		 * @inheritDoc
		 */
		/*override public function onEventBubbled(event:IEvent):Boolean
		 {
		 super.onEventBubbled(event);

		 var type:String = (event as ISignalEvent).type;

		 for each (var mapping:MappingVo in _signalTypeToCommandMappings)
		 {
		 if (mapping.signalType == type)
		 {
		 var command:ICommand = mapping.command;
		 command.execute();

		 break;
		 }
		 }
		 }

		 /**
		 * @inheritDoc
		 */
		public function addViewController(viewController:IViewController):void
		{
			if (!_viewList)
			{
				_viewList = new Dictionary();
			}

			var added:Boolean = addChild(viewController, _viewList);

			if (added)
			{
				_numViewControllers++;

				if (viewController.parent != null)
				{
					(viewController.parent as IContext).removeViewController(viewController);
				}
				(viewController as HierarchyObject).setParent(this);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function addViewControllers(...viewControllers):void
		{
			for (var i:int = 0; i < viewControllers.length; i++)
			{
				if(viewControllers[i] is IViewController)
				{
					addViewController(viewControllers[i]);
				}else
				{
					throw new Error("Object is not IViewController!");
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeViewController(viewController:IViewController, dispose:Boolean = false):void
		{
			var removed:Boolean = removeChild(viewController, _viewList);

			if (removed)
			{
				_numViewControllers--;

				if (dispose)
				{
					viewController.dispose();
				} else
				{
					(viewController as ViewController).setParent(null);
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeViewControllers(dispose:Boolean, ...viewControllers):void
		{
			for (var i:int = 0; i < viewControllers.length; i++)
			{
				removeViewController(viewControllers[i], dispose);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllViewControllers(dispose:Boolean = false):void
		{
			if (_viewList)
			{
				for (var i:* in _viewList)
				{
					//delete _viewList[i];

					if (dispose)
					{
						_viewList[i].dispose();
					} else
					{
						(_viewList[i] as HierarchyObject).setParent(null);
					}
				}

				_viewList = null;

				_numViewControllers = 0;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function get numViewControllers():int
		{
			return _numViewControllers;
		}

		/**
		 * @inheritDoc
		 */
		public function containsViewController(viewController:IViewController):Boolean
		{
			return _viewList && _viewList[viewController] != null;
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
			for each (var viewController:IViewController in _viewList)
			{
				viewController.dispatchSignal(event.type, event.data);
			}
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
		public function get viewControllerList():Dictionary
		{
			return _viewList;
		}
	}
}
