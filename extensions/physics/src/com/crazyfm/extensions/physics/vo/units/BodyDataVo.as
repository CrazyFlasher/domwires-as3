/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo.units
{
	import com.crazyfm.extensions.physics.vo.InteractionFilterVo;
	import com.crazyfm.extensions.physics.vo.ShapeMaterialVo;

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

		public function BodyDataVo(json:Object)
		{
			super(json);
		}

		[PostConstruct]
		public function init():void
		{
			var shapes:Vector.<ShapeDataVo> = new <ShapeDataVo>[];
			for each (var shapeJson:Object in json.shapes)
			{
				var shapeData:ShapeDataVo = factory.getInstance(ShapeDataVo, [shapeJson]);
				shapes.push(shapeData);
			}

			_shapeDataList = shapes;

			_material = factory.getInstance(ShapeMaterialVo, [json.material]);
			_interactionFilter = factory.getInstance(InteractionFilterVo, [json.filter]);

			if(json.angle != null)
			{
				_angle = json.angle;
			}
			if(json.allowRotation != null)
			{
				_allowRotation = json.allowRotation;
			}
			_type = json.type;
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
	}
}
