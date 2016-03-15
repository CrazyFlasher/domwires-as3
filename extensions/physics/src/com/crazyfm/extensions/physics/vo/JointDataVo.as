/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class JointDataVo
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _minAngle:Number = 0;
		private var _maxAngle:Number = 0;
		private var _id:String;
		private var _type:String;

		public function JointDataVo()
		{
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

		public function get minAngle():Number
		{
			return _minAngle;
		}

		public function set minAngle(value:Number):void
		{
			_minAngle = value;
		}

		public function get maxAngle():Number
		{
			return _maxAngle;
		}

		public function set maxAngle(value:Number):void
		{
			_maxAngle = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}
	}
}
