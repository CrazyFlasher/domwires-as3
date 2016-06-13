/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.extension.starlingApp.initializer.messages
{
	import com.crazyfm.core.common.Enum;

	public class StarlingInitializerMessageEnum extends Enum
	{
		public static const STARLING_INITIALIZED:StarlingInitializerMessageEnum = new StarlingInitializerMessageEnum("STARLING_INITIALIZED");

		public function StarlingInitializerMessageEnum(name:String)
		{
			super(name);
		}
	}
}
