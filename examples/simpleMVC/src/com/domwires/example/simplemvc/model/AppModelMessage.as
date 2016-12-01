/**
 * Created by CrazyFlasher on 1.12.2016.
 */
package com.domwires.example.simplemvc.model
{
	import com.domwires.core.common.Enum;

	public class AppModelMessage extends Enum
	{
		public static const FIRST_NAME_CHANGED:AppModelMessage = new AppModelMessage("FIRST_NAME_CHANGED");
		public static const LAST_NAME_CHANGED:AppModelMessage = new AppModelMessage("LAST_NAME_CHANGED");
		public static const AGE_CHANGED:AppModelMessage = new AppModelMessage("AGE_CHANGED");

		public function AppModelMessage(name:String)
		{
			super(name);
		}
	}
}
