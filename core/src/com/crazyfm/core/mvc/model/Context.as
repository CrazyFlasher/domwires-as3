/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.model
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObject;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;
	import com.crazyfm.core.mvc.hierarchy.ns_hierarchy;
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
//		private var _injector:Injector;
//		private var _signalTypeToCommandMappings:Vector.<MappingVo>;

		protected var _viewList:Vector.<IViewController> = new <IViewController>[];

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
		public function addViewController(viewController:IViewController):IContext
		{
			add(viewController, _viewList as Vector.<*>);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeViewController(viewController:IViewController, dispose:Boolean = false):IContext
		{
			remove(viewController, _viewList as Vector.<*>);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllViewControllers(dispose:Boolean = false):IContext
		{
			removeAll(dispose, _viewList as Vector.<*>);

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
			dispatchSignalToChildren(event.type, event.data, _viewList as Vector.<*>);
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
		public function get viewControllerList():Vector.<IViewController>
		{
			return _viewList;
		}

		override public function remove(child:IHierarchyObject, dispose:Boolean = false, fromList:Vector.<*> = null):IHierarchyObjectContainer
		{
			if (child is IViewController)
			{
				super.remove(child, dispose, _viewList as Vector.<*>);
			}

			return this;
		}
	}
}
