/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo.units
{
	import com.crazyfm.extensions.physics.vo.InteractionFilterVo;
	import com.crazyfm.extensions.physics.vo.ShapeMaterialVo;

	public class ShapeDataVo extends PhysicsUnitDataVo
	{
		private var _material:ShapeMaterialVo;
		private var _interactionFilter:InteractionFilterVo;
		private var _sensor:Boolean = false;

		private var _angle:Number = 0;

		private var _radius:Number;
		private var _vertexDataList:Vector.<VertexDataVo>;

		public function ShapeDataVo(json:Object)
		{
			super(json);
		}
		
		[PostConstruct]
		public function init():void
		{
			var vertices:Vector.<VertexDataVo> = new <VertexDataVo>[];
			for each (var vertexJson:Object in json.vertices)
			{
				var vertexData:VertexDataVo = factory.getInstance(VertexDataVo, [vertexJson]);
				vertices.push(vertexData);
			}

			_vertexDataList = vertices;

			if(json.angle != null)
			{
				_angle = json.angle;
			}
			if(json.isSensor != null)
			{
				_sensor = json.isSensor;
			}
			if(json.radius != null)
			{
				_radius = json.radius;
			}

			_material = factory.getInstance(ShapeMaterialVo, [json.material]);
			_interactionFilter = factory.getInstance(InteractionFilterVo, [json.filter]);
		}

		public function get vertexDataList():Vector.<VertexDataVo>
		{
			return _vertexDataList;
		}

		public function get material():ShapeMaterialVo
		{
			return _material;
		}

		public function get angle():Number
		{
			return _angle;
		}

		public function get interactionFilter():InteractionFilterVo
		{
			return _interactionFilter;
		}

		public function get sensor():Boolean
		{
			return _sensor;
		}

		public function get radius():Number
		{
			return _radius;
		}
	}
}
