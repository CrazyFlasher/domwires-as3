/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.Disposable;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import nape.geom.Vec2;

	use namespace ns_ext_physics;

	public class VertexObject extends Disposable implements IVertexObject
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

		ns_ext_physics function setData(value:VertexDataVo):IVertexObject
		{
			_data = value;

			_vertex = new Vec2(value.x, value.y);

			return this;
		}

		public function get data():VertexDataVo
		{
			return _data;
		}

		public function get vertex():Vec2
		{
			return _vertex;
		}

		override public function dispose():void
		{
			_vertex.dispose();

			_vertex = null;
			_data = null;

			super.dispose();
		}

		public function clone():IVertexObject
		{
			var c:VertexObject = new VertexObject();
			c.setData(_data);
			return c;
		}
	}
}
