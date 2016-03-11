/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class BodyDataVo
	{
		private var _shapesData:Vector.<ShapeDataVo>;

		public function BodyDataVo(shapesData:Vector.<ShapeDataVo>)
		{
			_shapesData = shapesData;
		}

		public function get shapesData():Vector.<ShapeDataVo>
		{
			return _shapesData;
		}
	}
}
