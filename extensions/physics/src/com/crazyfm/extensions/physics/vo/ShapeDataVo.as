/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class ShapeDataVo
	{
		private var _name:String;
		private var _material:ShapeMaterialVo;
		private var _x:Number;
		private var _y:Number;
		private var _angle:Number;

		private var _vertexDataList:Vector.<VertexDataVo>;

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

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
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
	}
}
