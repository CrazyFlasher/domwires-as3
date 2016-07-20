/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.extension.starlingApp.messages
{
	import com.crazyfm.core.common.Enum;

	public class StarlingInitializerMessage extends Enum
	{
		public static const STARLING_INITIALIZED:StarlingInitializerMessage = new StarlingInitializerMessage("STARLING_INITIALIZED");
		
		public static const STARLING_STAGE_RESIZE:StarlingInitializerMessage = new StarlingInitializerMessage("STARLING_STAGE_RESIZE");

		public function StarlingInitializerMessage(name:String)
		{
			super(name);
		}
	}
}
