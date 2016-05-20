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

		public function InteractionFilterVo(json:Object)
		{
			if (json)
			{
				if(json.collisionGroup != null)
				{
					_collisionGroup = json.collisionGroup;
				}
				if(json.collisionMask != null)
				{
					_collisionMask = json.collisionMask;
				}
				if(json.sensorGroup != null)
				{
					_sensorGroup = json.sensorGroup;
				}
				if(json.sensorMask != null)
				{
					_sensorMask = json.sensorMask;
				}
				if(json.fluidGroup != null)
				{
					_fluidGroup = json.fluidGroup;
				}
				if(json.fluidMask != null)
				{
					_fluidMask = json.fluidMask;
				}
			}
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
	}
}
