/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import nape.geom.Vec2;

	public class VertexObject implements IVertexObject
	{
		private var _vertex:Vec2;

		private var _data:VertexDataVo;

		public function VertexObject()
		{

		}

		public function get x():Number
		{
			return _data.x;
		}

		public function get y():Number
		{
			return _data.y;
		}

		public function set data(value:VertexDataVo):void
		{
			_data = value;
		}

		public function get data():VertexDataVo
		{
			return _data;
		}

		public function get vertex():Vec2
		{
			return _vertex;
		}
	}
}
