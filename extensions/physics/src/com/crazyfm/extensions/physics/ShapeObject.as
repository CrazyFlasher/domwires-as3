/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeMaterialVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.geom.Mat23;
	import nape.geom.Vec2;
	import nape.phys.Material;
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
				verticesVec2.push(new Vec2(vertexObject.vertex.x + _data.x, vertexObject.vertex.y + _data.y));
			}

			_shapes = new <Shape>[];

			var geom:GeomPoly = new GeomPoly(verticesVec2);
			var m:Mat23 = Mat23.rotation(_data.angle);
			geom.transform(m);

			var geomList:GeomPolyList = geom.convexDecomposition();
			var materialData:ShapeMaterialVo = _data.material;
			var material:Material = new Material(materialData.elasticity, materialData.dynamicFriction,
					materialData.staticFriction, materialData.density, materialData.rollingFriction);

			geomList.foreach(function(gp:GeomPoly):void {
				var poly:Polygon = new Polygon(gp);
				poly.material = material;
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
