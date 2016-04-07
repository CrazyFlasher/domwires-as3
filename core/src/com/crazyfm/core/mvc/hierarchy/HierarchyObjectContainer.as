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
		/*
		* Have to use Array instead of Vector, because of Vector casing issues and
		* "abc bytecode decoding failed" compile error.
		*/
		protected var _childrenList:Array = [];
		protected var _bubbledSignalListeners:Dictionary;

		public function HierarchyObjectContainer()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function add(child:IHierarchyObject):IHierarchyObjectContainer
		{
			if (_childrenList.indexOf(child) == -1)
			{
				_childrenList.push(child);

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
		public function remove(child:IHierarchyObject, dispose:Boolean = false):IHierarchyObjectContainer
		{
			var childIndex:int = _childrenList.indexOf(child);

			if (childIndex != -1)
			{
				_childrenList.removeAt(childIndex);

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
		public function removeAll(dispose:Boolean = false):IHierarchyObjectContainer
		{
			for each (var child:IHierarchyObject in _childrenList)
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

			if (_childrenList)
			{
				_childrenList.splice(0, _childrenList.length);
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

			_childrenList = null;

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchSignalToChildren(type:Enum, data:Object = null):void
		{
			for each (var child:IHierarchyObject in _childrenList)
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