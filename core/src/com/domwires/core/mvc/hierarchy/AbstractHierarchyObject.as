/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.domwires.core.mvc.hierarchy
{
	import com.domwires.core.mvc.message.MessageDispatcher;

	use namespace ns_hierarchy;

	/**
	 * Object, that part of hierarchy. Can dispatch and receive messages from hierarchy branch.
	 */
	public class AbstractHierarchyObject extends MessageDispatcher implements IHierarchyObject
	{
		private var _parent:IHierarchyObjectContainer;

		public function AbstractHierarchyObject()
		{
			super();
		}

		ns_hierarchy function setParent(value:IHierarchyObjectContainer):void
		{
			var hasParent:Boolean = _parent != null;

			_parent = value;

			if (!hasParent && _parent != null)
			{
				addedToHierarchy();
			}else
			if(hasParent && _parent == null)
			{
				removedFromHierarchy();
			}
		}

		/**
		 * Called, when object added to hierarchy.
		 */
		protected function removedFromHierarchy():void
		{

		}

		/**
		 * Called, when object removed from hierarchy.
		 */
		protected function addedToHierarchy():void
		{

		}

		/**
		 * @inheritDoc
		 */
		public function get parent():IHierarchyObjectContainer
		{
			return _parent;
		}

		/**
		 * Disposes hierarchy object and removes reference to parent, if has one.
		 */
		override public function dispose():void
		{
			_parent = null;

			super.dispose();
		}
	}
}
