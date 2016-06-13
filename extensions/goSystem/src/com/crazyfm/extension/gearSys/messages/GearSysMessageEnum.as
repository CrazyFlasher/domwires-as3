/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.extension.gearSys.messages
{
	import com.crazyfm.core.common.Enum;

	public class GearSysMessageEnum extends Enum
	{
		public static const INITIALIZED:GearSysMessageEnum = new GearSysMessageEnum("INITIALIZED");
		public static const STEP:GearSysMessageEnum = new GearSysMessageEnum("STEP");

		public function GearSysMessageEnum(name:String)
		{
			super(name);
		}
	}
}
