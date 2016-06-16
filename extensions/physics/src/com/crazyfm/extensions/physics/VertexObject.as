/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.AbstractDisposable;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.extensions.physics.vo.units.VertexDataVo;

	import nape.geom.Vec2;

	public class VertexObject extends AbstractDisposable implements IVertexObject
	{
		[Autowired]
		public var factory:IAppFactory;

		private var _vertex:Vec2;

		private var _data:VertexDataVo;

		public function VertexObject(data:VertexDataVo)
		{
			super();

			_data = data;
		}

		[PostConstruct]
		public function init():void
		{
			_vertex = new Vec2(_data.x, _data.y);
		}

		public function get x():Number
		{
			return _data.x;
		}

		public function get y():Number
		{
			return _data.y;
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
			factory = null;

			super.dispose();
		}

		public function clone():IVertexObject
		{
			var c:IVertexObject = factory.getInstance(IVertexObject, [_data]);
			return c;
		}
	}
}
