/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.event
{
	import com.crazyfm.core.common.Enum;

	public class PhysObjectSignalEnum extends Enum
	{
		public static const COLLISION_BEGIN:PhysObjectSignalEnum = new PhysObjectSignalEnum("collisionBegin");
		public static const COLLISION_END:PhysObjectSignalEnum = new PhysObjectSignalEnum("collisionEnd");
		public static const COLLISION_ONGOING:PhysObjectSignalEnum = new PhysObjectSignalEnum("collisionOnGoing");

		public static const SENSOR_BEGIN:PhysObjectSignalEnum = new PhysObjectSignalEnum("sensorBegin");
		public static const SENSOR_END:PhysObjectSignalEnum = new PhysObjectSignalEnum("sensorEnd");
		public static const SENSOR_ONGOING:PhysObjectSignalEnum = new PhysObjectSignalEnum("sensorOngoing");

		public function PhysObjectSignalEnum(name:String)
		{
			super(name);
		}

	}
}
