/**
 * Created by Anton Nefjodov on 14.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class GravityVo
	{
		private var _x:Number;
		private var _y:Number;

		public function GravityVo(x:Number = 0, y:Number = 9.8)
		{
			_x = x;
			_y = y;
		}

		public function get x():Number
		{
			return _x;
		}

		public function get y():Number
		{
			return _y;
		}
	}
}
