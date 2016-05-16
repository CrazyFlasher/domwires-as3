/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class ShapeDataVo
	{
		private var _id:String;
		private var _material:ShapeMaterialVo = new ShapeMaterialVo();
		private var _interactionFilter:InteractionFilterVo = new InteractionFilterVo();
		private var _sensor:Boolean = false;

		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _angle:Number = 0;

		private var _radius:Number;
		private var _vertexDataList:Vector.<VertexDataVo>;

		private var _customData:Object = {};

		//TODO: create factory
		public function ShapeDataVo()
		{
		}

		public function get vertexDataList():Vector.<VertexDataVo>
		{
			return _vertexDataList;
		}

		public function set vertexDataList(value:Vector.<VertexDataVo>):void
		{
			_vertexDataList = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set name(value:String):void
		{
			_id = value;
		}

		public function get material():ShapeMaterialVo
		{
			return _material;
		}

		public function set material(value:ShapeMaterialVo):void
		{
			_material = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get angle():Number
		{
			return _angle;
		}

		public function set angle(value:Number):void
		{
			_angle = value;
		}

		public function set id(value:String):void
		{
			_id = value;
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

		public function get customData():Object
		{
			return _customData;
		}

		public function set customData(value:Object):void
		{
			_customData = value;
		}
	}
}
