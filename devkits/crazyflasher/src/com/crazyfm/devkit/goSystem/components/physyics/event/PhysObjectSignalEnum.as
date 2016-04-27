/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.event
{
	import com.crazyfm.core.common.Enum;

	public class PhysObjectSignalEnum extends Enum
	{
		public static const COLLISION_BEGIN:PhysObjectSignalEnum = new PhysObjectSignalEnum("COLLISION_BEGIN");
		public static const COLLISION_END:PhysObjectSignalEnum = new PhysObjectSignalEnum("COLLISION_END");
		public static const COLLISION_ONGOING:PhysObjectSignalEnum = new PhysObjectSignalEnum("COLLISION_ONGOING");

		public static const SENSOR_BEGIN:PhysObjectSignalEnum = new PhysObjectSignalEnum("SENSOR_BEGIN");
		public static const SENSOR_END:PhysObjectSignalEnum = new PhysObjectSignalEnum("SENSOR_END");
		public static const SENSOR_ONGOING:PhysObjectSignalEnum = new PhysObjectSignalEnum("SENSOR_ONGOING");

		public function PhysObjectSignalEnum(name:String)
		{
			super(name);
		}

	}
}
