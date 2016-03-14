/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class VertexDataVo
	{
		private var _id:String;
		private var _x:Number = 0;
		private var _y:Number = 0;

		public function VertexDataVo(x:Number = 0, y:Number = 0, id:String = null)
		{
			_x = x;
			_y = y;
			_id = id;
		}

		public function get x():Number
		{
			return _x;
		}

		public function get y():Number
		{
			return _y;
		}

		public function get id():String
		{
			return _id;
		}
	}
}
