/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;

	public class Model extends SignalDispatcher implements IModel
	{
		private var _parent:IModelContainer;

		public function Model()
		{
		}

		public function set parent(value:IModelContainer):void
		{
			_parent = value;
		}

		public function get parent():IModelContainer
		{
			return _parent;
		}

		override public function dispose():void
		{
			_parent = null;

			super.dispose();
		}
	}
}
