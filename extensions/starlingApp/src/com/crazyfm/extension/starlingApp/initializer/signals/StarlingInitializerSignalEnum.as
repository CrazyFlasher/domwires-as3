/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.extension.starlingApp.initializer.signals
{
	import com.crazyfm.core.common.Enum;

	public class StarlingInitializerSignalEnum extends Enum
	{
		public static const STARLING_INITIALIZED:StarlingInitializerSignalEnum = new StarlingInitializerSignalEnum("STARLING_INITIALIZED");

		public function StarlingInitializerSignalEnum(name:String)
		{
			super(name);
		}
	}
}
