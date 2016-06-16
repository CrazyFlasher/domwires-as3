/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.AbstractDisposable;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.extensions.physics.vo.InteractionFilterVo;
	import com.crazyfm.extensions.physics.vo.ShapeMaterialVo;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.units.VertexDataVo;

	import nape.dynamics.InteractionFilter;
	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.geom.Mat23;
	import nape.geom.Vec2;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	public class ShapeObject extends AbstractDisposable implements IShapeObject
	{
		[Autowired]
		public var factory:IAppFactory;

		private var _shapes:Vector.<Shape>;

		private var _data:ShapeDataVo;

		private var _vertexObjectList:Vector.<IVertexObject>;

		public function ShapeObject(data:ShapeDataVo)
		{
			//TODO: a lot of tests
			super();

			_data = data;
		}

		[PostConstruct]
		public function init():void
		{
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
					var vertexObject:IVertexObject = factory.getInstance(IVertexObject, [vertexData]);

					_vertexObjectList.push(vertexObject);
					verticesVec2.push(new Vec2(vertexObject.vertex.x, vertexObject.vertex.y));
				}

				var geom:GeomPoly = new GeomPoly(verticesVec2);
				var m_1:Mat23 = Mat23.rotation(_data.angle);
				var m_2:Mat23 = Mat23.translation(_data.x, _data.y);
				geom.transform( m_1.concat(m_2));

				var geomList:GeomPolyList = geom.convexDecomposition();

				var dataObject:IShapeObject = this;

				geomList.foreach(function(gp:GeomPoly):void {
					var poly:Polygon = new Polygon(gp);
					poly.sensorEnabled = _data.sensor;
					poly.material = material;
					poly.filter = filter;
					poly.userData.dataObject = dataObject;

					applyCustomData(poly);

					_shapes.push(poly);
				});
			}else
			{
				var circlePoly:Circle = new Circle(_data.radius/*, new Vec2(_data.x, _data.y)*/);
				circlePoly.sensorEnabled = _data.sensor;
				circlePoly.material = material;
				circlePoly.filter = filter;
				circlePoly.transform(Mat23.translation(_data.x, _data.y));
				circlePoly.userData.dataObject = dataObject;

				applyCustomData(circlePoly);

				_shapes.push(circlePoly);
			}
		}

		protected function applyCustomData(shape:Shape):void
		{
			//override
		}

		public function get vertexObjectList():Vector.<IVertexObject>
		{
			return _vertexObjectList;
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
			factory = null;

			super.dispose();
		}

		public function clone():IShapeObject
		{
			var c:IShapeObject = factory.getInstance(IShapeObject, [_data]);
			return c;
		}
	}
}
