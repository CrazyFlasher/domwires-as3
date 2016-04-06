/**
 * Created by Anton Nefjodov on 6.04.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.event.ISignalEvent;

	import flash.utils.Dictionary;

	import org.osflash.signals.events.IEvent;

	use namespace ns_hierarchy;

	public class HierarchyObjectContainer extends HierarchyObject implements IHierarchyObjectContainer
	{
		protected var _childrenList:Vector.<IHierarchyObject> = new <IHierarchyObject>[];
		protected var _bubbledSignalListeners:Dictionary;

		public function HierarchyObjectContainer()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function add(child:IHierarchyObject, toList:Vector.<*> = null):IHierarchyObjectContainer
		{
			var list:Vector.<*> = (toList == null ? _childrenList as Vector.<*> : toList);

			if (list.indexOf(child) == -1)
			{
				list.push(child);

				if (child.parent != null)
				{
					child.parent.remove(child);
				}
				(child as HierarchyObject).setParent(this);
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function remove(child:IHierarchyObject, dispose:Boolean = false, fromList:Vector.<*> = null):IHierarchyObjectContainer
		{
			var list:Vector.<*> = (fromList == null ? _childrenList as Vector.<*> : fromList);

			var childIndex:int = list.indexOf(child);

			if (childIndex != -1)
			{
				list.removeAt(childIndex);

				if (dispose)
				{
					child.dispose();
				} else
				{
					(child as HierarchyObject).setParent(null);
				}
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAll(dispose:Boolean = false, fromList:Vector.<*> = null):IHierarchyObjectContainer
		{
			var list:Vector.<*> = (fromList == null ? _childrenList as Vector.<*> : fromList);

			for each (var child:IHierarchyObject in list)
			{
				if (dispose)
				{
					if (child is IHierarchyObjectContainer)
					{
						(child as IHierarchyObjectContainer).disposeWithAllChildren();
					}else
					{
						child.dispose();
					}

				} else
				{
					(child as HierarchyObject).setParent(null);
				}
			}

			if (list)
			{
				list.splice(0, list.length);
			}

			return this;
		}

		/**
		 * Disposes object and removes all children, but doesn't dispose them.
		 */
		override public function dispose():void
		{
			removeAll();

			_childrenList = null;

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function onEventBubbled(event:IEvent):Boolean
		{
			var type:Enum = (event as ISignalEvent).type;

			if (getBubbledSignalListeners()[type] != null)
			{
				return getBubbledSignalListeners()[type](event);
			}

			return true;
		}

		/**
		 * @inheritDoc
		 */
		override public function addSignalListener(type:Enum, listener:Function):void
		{
			super.addSignalListener(type, listener);

			getBubbledSignalListeners()[type] = listener;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeSignalListener(type:Enum):void
		{
			super.removeSignalListener(type);

			delete getBubbledSignalListeners()[type];
		}

		/**
		 * @inheritDoc
		 */
		override public function removeAllSignalListeners():void
		{
			super.removeAllSignalListeners();

			if (_bubbledSignalListeners)
			{
				for (var type:* in _bubbledSignalListeners)
				{
					delete _bubbledSignalListeners[type];
				}

				_bubbledSignalListeners = null
			}
		}

		private function getBubbledSignalListeners():Dictionary
		{
			if (!_bubbledSignalListeners)
			{
				_bubbledSignalListeners = new Dictionary();
			}

			return _bubbledSignalListeners;
		}

		/**
		 * @inheritDoc
		 */
		public function disposeWithAllChildren():void
		{
			removeAll(true);

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchSignalToChildren(type:Enum, data:Object = null, inList:Vector.<*> = null):void
		{
			var list:Vector.<*> = (inList == null ? _childrenList as Vector.<*> : inList);

			for each (var child:IHierarchyObject in list)
			{
				if(child is IHierarchyObject)
				{
					child.dispatchSignal(type, data, false);
				}else
				if(child is IHierarchyObjectContainer)
				{
					(child as IHierarchyObjectContainer).dispatchSignalToChildren(type, data);
				}
			}
		}
	}
}