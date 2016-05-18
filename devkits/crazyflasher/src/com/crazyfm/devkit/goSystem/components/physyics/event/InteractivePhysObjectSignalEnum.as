/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.event
{
	import com.crazyfm.core.common.Enum;

	public class InteractivePhysObjectSignalEnum extends Enum
	{
		public static const TELEPORT_COMPLETE:InteractivePhysObjectSignalEnum = new InteractivePhysObjectSignalEnum("TELEPORT_COMPLETE");

		public function InteractivePhysObjectSignalEnum(name:String)
		{
			super(name);
		}
	}
}
