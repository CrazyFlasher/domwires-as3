/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.HierarchyObject;

	public class GOSystemComponent extends HierarchyObject implements IGOSystemComponent
	{
		public function GOSystemComponent()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function get gameObject():IGOSystemObject
		{
			return parent as IGOSystemObject;
		}

		/**
		 * @inheritDoc
		 */
		public function interact(timePassed:Number):void
		{

		}
	}
}
