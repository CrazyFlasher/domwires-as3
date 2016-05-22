/**
 * Created by Anton Nefjodov on 17.05.2016.
 */
package com.crazyfm.extensions.physics.vo.units
{
	public class PhysicsUnitDataVo
	{
		private var _id:String;

		private var _x:Number = 0;
		private var _y:Number = 0;

		private var _customData:Object = {};

		public function PhysicsUnitDataVo(json:Object)
		{
			_x = json.x;
			_y = json.y;
			_id = json.id;

			if (json.customData)
			{
				_customData = json.customData;
			}
		}

		public function get id():String
		{
			return _id;
		}

		public function get x():Number
		{
			return _x;
		}

		public function get y():Number
		{
			return _y;
		}

		public function get customData():Object
		{
			return _customData;
		}
	}
}
