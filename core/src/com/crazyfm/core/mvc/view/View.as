/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.view
{
	import com.crazyfm.core.mvc.hierarchy.HierarchyObject;

	import flash.display.DisplayObjectContainer;

	public class View extends HierarchyObject implements IView
	{
		protected var container:DisplayObjectContainer;

		public function View(container:DisplayObjectContainer)
		{
			super();

			this.container = container;
		}

		override public function dispose():void
		{
			container = null;

			super.dispose();
		}
	}
}
