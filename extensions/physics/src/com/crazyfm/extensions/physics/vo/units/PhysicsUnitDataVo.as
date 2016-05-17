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

		public function PhysicsUnitDataVo()
		{
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get customData():Object
		{
			return _customData;
		}

		public function set customData(value:Object):void
		{
			_customData = value;
		}
	}
}
