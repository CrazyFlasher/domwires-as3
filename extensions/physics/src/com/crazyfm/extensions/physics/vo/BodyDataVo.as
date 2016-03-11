/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class BodyDataVo
	{
		private var _shapeDataList:Vector.<ShapeDataVo>;

		public function BodyDataVo(shapeDataList:Vector.<ShapeDataVo>)
		{
			_shapeDataList = shapeDataList;
		}

		public function get shapeDataList():Vector.<ShapeDataVo>
		{
			return _shapeDataList;
		}
	}
}
