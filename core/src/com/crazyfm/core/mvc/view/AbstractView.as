/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.view
{
	import com.crazyfm.core.mvc.hierarchy.AbstractHierarchyObject;

	import flash.display.DisplayObjectContainer;

	public class AbstractView extends AbstractHierarchyObject implements IView
	{
		protected var container:DisplayObjectContainer;

		public function AbstractView(container:DisplayObjectContainer)
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
