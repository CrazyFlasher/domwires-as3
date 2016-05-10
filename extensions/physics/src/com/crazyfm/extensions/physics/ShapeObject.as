/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.Disposable;
	import com.crazyfm.extensions.physics.vo.InteractionFilterVo;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeMaterialVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import nape.dynamics.InteractionFilter;
	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.geom.Mat23;
	import nape.geom.Vec2;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	use namespace ns_ext_physics;

	public class ShapeObject extends Disposable implements IShapeObject
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

		ns_ext_physics function setData(value:ShapeDataVo):IShapeObject
		{
			//TODO: a lot of tests

			_data = value;

			var materialData:ShapeMaterialVo = _data.material;
			var material:Material = new Material(materialData.elasticity, materialData.dynamicFriction,
					materialData.staticFriction, materialData.density, materialData.rollingFriction);

			var filterData:InteractionFilterVo = _data.interactionFilter;
			var filter:InteractionFilter = new InteractionFilter(filterData.collisionGroup, filterData.collisionMask,
					filterData.sensorGroup, filterData.sensorMask, filterData.fluidGroup, filterData.fluidMask);

			_shapes = new <Shape>[];

			if (isNaN(_data.radius))
			{
				_vertexObjectList = new <IVertexObject>[];
				var verticesVec2:Vector.<Vec2> = new <Vec2>[];

				for each (var vertexData:VertexDataVo in _data.vertexDataList)
				{
					var vertexObject:VertexObject = new VertexObject();
					vertexObject.setData(vertexData);

					_vertexObjectList.push(vertexObject);
					verticesVec2.push(new Vec2(vertexObject.vertex.x, vertexObject.vertex.y));
				}

				var geom:GeomPoly = new GeomPoly(verticesVec2);
				var m_1:Mat23 = Mat23.rotation(_data.angle);
				var m_2:Mat23 = Mat23.translation(_data.x, _data.y);
				geom.transform( m_1.concat(m_2));

				var geomList:GeomPolyList = geom.convexDecomposition();

				geomList.foreach(function(gp:GeomPoly):void {
					var poly:Polygon = new Polygon(gp);
					poly.sensorEnabled = _data.sensor;
					poly.material = material;
					poly.filter = filter;
					poly.userData.id = _data.id;
					_shapes.push(poly);
				});
			}else
			{
				var circlePoly:Circle = new Circle(_data.radius/*, new Vec2(_data.x, _data.y)*/);
				circlePoly.sensorEnabled = _data.sensor;
				circlePoly.material = material;
				circlePoly.filter = filter;
				circlePoly.transform(Mat23.translation(_data.x, _data.y));
				circlePoly.userData.id = _data.id;
				_shapes.push(circlePoly);
			}

			return this;
		}

		public function get data():ShapeDataVo
		{
			return _data;
		}

		public function get shapes():Vector.<Shape>
		{
			return _shapes;
		}

		override public function dispose():void
		{
			for each (var vertexObject:IVertexObject in _vertexObjectList)
			{
				vertexObject.dispose();
			}
			
			_vertexObjectList = null;
			_shapes = null;
			_data = null;

			super.dispose();
		}

		public function clone():IShapeObject
		{
			var c:ShapeObject = new ShapeObject();
			c.setData(_data);
			return c;
		}
	}
}
