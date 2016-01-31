/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;

	use namespace model_ns;

	public class Model extends SignalDispatcher implements IModel
	{
		namespace anton;

		private var _parent:IModelContainer;

		public function Model()
		{
		}

		model_ns function setParent(value:IModelContainer):void
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
