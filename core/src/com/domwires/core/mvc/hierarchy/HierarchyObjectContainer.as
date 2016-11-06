/**
 * Created by Anton Nefjodov on 6.04.2016.
 */
package com.domwires.core.mvc.hierarchy
{
	import com.domwires.core.mvc.message.IMessage;

	use namespace ns_hierarchy;

	/**
	 * Container of <code>IHierarchyObject</code>s
	 */
	public class HierarchyObjectContainer extends AbstractHierarchyObject implements IHierarchyObjectContainer
	{
		/*
		* Have to use Array instead of Vector, because of Vector casing issues and
		* "abc bytecode decoding failed" compile error.
		*/
		private var _childrenList:Array = [];

		/**
		 * @inheritDoc
		 */
		public function add(child:IHierarchyObject, index:int = -1):IHierarchyObjectContainer
		{
			if (index != -1 && index > _childrenList.length)
			{
				throw new Error("Invalid child index! Index shouldn't be bigger that children list length!");
			}

			var contains:Boolean = _childrenList.indexOf(child) != -1;

			if (index != -1)
			{
				if (contains)
				{
					_childrenList.removeAt(_childrenList.indexOf(child))
				}
				_childrenList.insertAt(index, child);
			}

			if (!contains)
			{
				if (index == -1)
				{
					_childrenList.push(child);
				}

				if (child.parent != null)
				{
					child.parent.remove(child);
				}
				(child as AbstractHierarchyObject).setParent(this);
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
					(child as AbstractHierarchyObject).setParent(null);
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
					(child as AbstractHierarchyObject).setParent(null);
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
		public function onMessageBubbled(message:IMessage):Boolean
		{
			handleMessage(message);

			return true;
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
		public function get children():Array
		{
			return _childrenList;
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchMessageToChildren(message:IMessage):void
		{
			for each (var child:IHierarchyObject in _childrenList)
			{
				if (message.previousTarget != child)
				{
					if(child is IHierarchyObjectContainer)
					{
						(child as IHierarchyObjectContainer).dispatchMessageToChildren(message);
					}else
					if(child is IHierarchyObject)
					{
						child.handleMessage(message);
					}
				}
			}
		}
	}
}