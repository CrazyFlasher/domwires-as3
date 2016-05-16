/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	//TODO: create from builder. Mark setters as internal.
	public class BodyDataVo
	{
		public static const TYPE_STATIC:String = "static";
		public static const TYPE_DYNAMIC:String = "dynamic";
		public static const TYPE_KINEMATIC:String = "kinematic";

		private var _id:String;
		private var _type:String = "dynamic";
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _angle:Number = 0;
		private var _allowRotation:Boolean = true;
		private var _material:ShapeMaterialVo;
		private var _interactionFilter:InteractionFilterVo;

		private var _shapeDataList:Vector.<ShapeDataVo>;

		private var _customData:Object;

		public function BodyDataVo()
		{
		}

		public function set shapeDataList(value:Vector.<ShapeDataVo>):void
		{
			_shapeDataList = value;
		}

		public function get shapeDataList():Vector.<ShapeDataVo>
		{
			return _shapeDataList;
		}

		public function get id():String
		{
			return _id;
		}

		public function get type():String
		{
			return _type;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function get y():Number
		{
			return _y;
		}

		public function get angle():Number
		{
			return _angle;
		}

		public function get allowRotation():Boolean
		{
			return _allowRotation;
		}

		public function get material():ShapeMaterialVo
		{
			return _material;
		}

		public function get interactionFilter():InteractionFilterVo
		{
			return _interactionFilter;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function set angle(value:Number):void
		{
			_angle = value;
		}

		public function set allowRotation(value:Boolean):void
		{
			_allowRotation = value;
		}

		public function set material(value:ShapeMaterialVo):void
		{
			_material = value;
		}

		public function set interactionFilter(value:InteractionFilterVo):void
		{
			_interactionFilter = value;
		}

		public function set customData(customData:Object):void
		{
			_customData = customData;
		}

		public function get customData():Object
		{
			return _customData;
		}
	}
}
