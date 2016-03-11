/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.geom.Vec2;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	public class ShapeObject implements IShapeObject
	{
		private var _shapes:Vector.<Shape>;

		private var _data:ShapeDataVo;

		private var _vertexObjectList:Vector.<IVertexObject>;

		public function ShapeObject()
		{
		}

		public function get vertexObjectList():Vector.<IVertexObject>
		{
			return _vertexObjectList;
		}

		public function set data(value:ShapeDataVo):void
		{
			_data = value;

			_vertexObjectList = new <IVertexObject>[];
			var verticesVec2:Vector.<Vec2> = new <Vec2>[];

			for each (var vertexData:VertexDataVo in _data.vertexDataList)
			{
				var vertexObject:IVertexObject = new VertexObject();
				vertexObject.data = vertexData;

				_vertexObjectList.push(vertexObject);
				verticesVec2.push(vertexObject.vertex);
			}

			_shapes = new <Shape>[];

			var geom:GeomPoly = new GeomPoly(verticesVec2);
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
