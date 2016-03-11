/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class ShapeDataVo
	{
		private var _vertexDataList:Vector.<VertexDataVo>;

		public function ShapeDataVo(vertexDataList:Vector.<VertexDataVo>)
		{
			_vertexDataList = vertexDataList;
		}

		public function get vertexDataList():Vector.<VertexDataVo>
		{
			return _vertexDataList;
		}
	}
}
