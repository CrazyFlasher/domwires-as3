/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class ShapeDataVo
	{
		private var _verticesData:Vector.<VertexDataVo>;

		public function ShapeDataVo(verticesData:Vector.<VertexDataVo>)
		{
			_verticesData = verticesData;
		}

		public function get verticesData():Vector.<VertexDataVo>
		{
			return _verticesData;
		}
	}
}
