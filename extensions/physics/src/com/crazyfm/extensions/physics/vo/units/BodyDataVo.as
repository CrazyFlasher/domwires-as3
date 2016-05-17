/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo.units
{
	import com.crazyfm.extensions.physics.vo.*;

	//TODO: create from builder. Mark setters as internal.
	public class BodyDataVo extends PhysicsUnitDataVo
	{
		public static const TYPE_STATIC:String = "static";
		public static const TYPE_DYNAMIC:String = "dynamic";
		public static const TYPE_KINEMATIC:String = "kinematic";

		private var _type:String = "dynamic";
		private var _angle:Number = 0;
		private var _allowRotation:Boolean = true;
		private var _material:ShapeMaterialVo;
		private var _interactionFilter:InteractionFilterVo;

		private var _shapeDataList:Vector.<ShapeDataVo>;

		public function BodyDataVo()
		{
			super();
		}

		public function set shapeDataList(value:Vector.<ShapeDataVo>):void
		{
			_shapeDataList = value;
		}

		public function get shapeDataList():Vector.<ShapeDataVo>
		{
			return _shapeDataList;
		}

		public function get type():String
		{
			return _type;
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
	}
}
