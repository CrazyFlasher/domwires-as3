/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.mvc.hierarchy
{
	import com.crazyfm.core.mvc.message.IMessage;
	import com.crazyfm.core.mvc.message.MessageDispatcher;

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
			_parent = value;
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
