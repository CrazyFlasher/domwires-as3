/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.extension.goSystem.events
{
	import com.crazyfm.core.common.Enum;

	public class GOSystemSignalEnum extends Enum
	{
		public static const INITIALIZED:GOSystemSignalEnum = new GOSystemSignalEnum("INITIALIZED");
		public static const STEP:GOSystemSignalEnum = new GOSystemSignalEnum("STEP");

		public function GOSystemSignalEnum(name:String)
		{
			super(name);
		}
	}
}
