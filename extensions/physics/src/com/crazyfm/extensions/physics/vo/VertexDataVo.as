/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class VertexDataVo
	{
		private var _x:Number;
		private var _y:Number;

		public function VertexDataVo(x:Number, y:Number)
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
