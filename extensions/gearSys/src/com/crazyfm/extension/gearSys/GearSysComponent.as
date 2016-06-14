/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	public class GearSysComponent extends AbstractGearSysGearWheel implements IGearSysComponent
	{
		public function GearSysComponent()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function get gameObject():IGearSysObject
		{
			return parent as IGearSysObject;
		}
	}
}
