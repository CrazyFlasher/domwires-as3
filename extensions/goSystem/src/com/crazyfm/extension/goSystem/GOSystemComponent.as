/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	public class GOSystemComponent extends AbstractGOSystemGearWheel implements IGOSystemComponent
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
	}
}
