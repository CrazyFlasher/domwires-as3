/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.model
{
	import com.crazy.mvc.event.SignalDispatcher;

	/**
	 * Model object that can be used for working with data and other logical non-view operations.
	 */
	public class Model extends SignalDispatcher implements IModel
	{
		private var _parent:IModelContainer;

		public function Model()
		{
		}

		internal function setParent(value:IModelContainer):void
		{
			_parent = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get parent():IModelContainer
		{
			return _parent;
		}

		/**
		 * Disposes model and removes reference to parent, if has one.
		 */
		override public function dispose():void
		{
			_parent = null;

			super.dispose();
		}
	}
}
