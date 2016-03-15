/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class InteractionFilterVo
	{
		private var _collisionGroup:int = 1;
		private var _collisionMask:int = -1;
		private var _sensorGroup:int = 1;
		private var _sensorMask:int = -1;
		private var _fluidGroup:int = 1;
		private var _fluidMask:int = -1;

		public function InteractionFilterVo()
		{
		}

		public function get collisionGroup():int
		{
			return _collisionGroup;
		}

		public function get collisionMask():int
		{
			return _collisionMask;
		}

		public function get sensorGroup():int
		{
			return _sensorGroup;
		}

		public function get sensorMask():int
		{
			return _sensorMask;
		}

		public function get fluidGroup():int
		{
			return _fluidGroup;
		}

		public function get fluidMask():int
		{
			return _fluidMask;
		}

		public function set collisionGroup(value:int):void
		{
			_collisionGroup = value;
		}

		public function set collisionMask(value:int):void
		{
			_collisionMask = value;
		}

		public function set sensorGroup(value:int):void
		{
			_sensorGroup = value;
		}

		public function set sensorMask(value:int):void
		{
			_sensorMask = value;
		}

		public function set fluidGroup(value:int):void
		{
			_fluidGroup = value;
		}

		public function set fluidMask(value:int):void
		{
			_fluidMask = value;
		}
	}
}
