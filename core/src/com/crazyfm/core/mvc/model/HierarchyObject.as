/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.mvc.model
{
	import com.crazyfm.core.mvc.event.SignalDispatcher;

	use namespace ns_hierarchy;

	public class HierarchyObject extends SignalDispatcher implements IHierarchyObject
	{
		private var _parent:IHierarchyObject;

		public function HierarchyObject()
		{

		}

		ns_hierarchy function setParent(value:IHierarchyObject):void
		{
			_parent = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get parent():IHierarchyObject
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
