/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	public class ShapeObject implements IShapeObject
	{
		private var _shapes:Vector.<Shape>;

		private var _data:ShapeDataVo;

		private var _verticesDataList:Vector.<IVertexObject>;

		public function ShapeObject()
		{
		}

		public function get verticesDataList():Vector.<IVertexObject>
		{
			return _verticesDataList;
		}

		public function set data(value:ShapeDataVo):void
		{
			_data = value;

			_verticesDataList = new <IVertexObject>[];

			for each (var vertexData:VertexDataVo in _data.verticesData)
			{
				var vertexObject:IVertexObject = new VertexObject();
				vertexObject.data = vertexData;
				_verticesDataList.push(vertexObject);
			}

			_shapes = new <Shape>[];

			var geom:GeomPoly = new GeomPoly(_verticesDataList);
			var geomList:GeomPolyList = geom.convexDecomposition();
			geomList.foreach(function(gp:GeomPoly):void {
				var poly:Polygon = new Polygon(gp);
				_shapes.push(poly);
			});
		}

		public function get data():ShapeDataVo
		{
			return _data;
		}

		public function get shapes():Vector.<Shape>
		{
			return _shapes;
		}
	}
}
