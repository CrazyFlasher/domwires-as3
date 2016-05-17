/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo.units
{
	import com.crazyfm.extensions.physics.vo.*;

	public class ShapeDataVo extends PhysicsUnitDataVo
	{
		private var _material:ShapeMaterialVo;
		private var _interactionFilter:InteractionFilterVo;
		private var _sensor:Boolean = false;

		private var _angle:Number = 0;

		private var _radius:Number;
		private var _vertexDataList:Vector.<VertexDataVo>;

		//TODO: create factory
		public function ShapeDataVo()
		{
			super();
		}

		public function get vertexDataList():Vector.<VertexDataVo>
		{
			return _vertexDataList;
		}

		public function set vertexDataList(value:Vector.<VertexDataVo>):void
		{
			_vertexDataList = value;
		}

		public function get material():ShapeMaterialVo
		{
			return _material;
		}

		public function set material(value:ShapeMaterialVo):void
		{
			_material = value;
		}

		public function get angle():Number
		{
			return _angle;
		}

		public function set angle(value:Number):void
		{
			_angle = value;
		}

		public function get interactionFilter():InteractionFilterVo
		{
			return _interactionFilter;
		}

		public function set interactionFilter(value:InteractionFilterVo):void
		{
			_interactionFilter = value;
		}

		public function get sensor():Boolean
		{
			return _sensor;
		}

		public function set sensor(value:Boolean):void
		{
			_sensor = value;
		}

		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(value:Number):void
		{
			_radius = value;
		}
	}
}
