/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.Disposable;
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;

	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;

	public class BodyObject extends Disposable implements IBodyObject
	{
		private var _body:Body;

		private var _data:BodyDataVo;

		private var _shapeObjectList:Vector.<IShapeObject>;

		public function BodyObject()
		{
		}

		public function get shapeObjectList():Vector.<IShapeObject>
		{
			return _shapeObjectList;
		}

		public function shapeObjectById(id:String):IShapeObject
		{
			for each (var shapeObject:IShapeObject in _shapeObjectList)
			{
				if (shapeObject.data.id == id)
				{
					return shapeObject;
				}
			}

			return null;
		}

		public function set data(value:BodyDataVo):void
		{
			_data = value;

			_shapeObjectList = new <IShapeObject>[];

			for each (var shapeData:ShapeDataVo in _data.shapeDataList)
			{
				var shapeObject:IShapeObject = new ShapeObject();
				shapeObject.data = shapeData;
				_shapeObjectList.push(shapeObject);
			}

			var bodyType:BodyType;
			switch (_data.type)
			{
				case BodyDataVo.TYPE_STATIC:
					bodyType = BodyType.STATIC;
					break;
				case BodyDataVo.TYPE_KINEMATIC:
					bodyType = BodyType.KINEMATIC;
					break;
				default:
					bodyType = BodyType.DYNAMIC;
					break;
			}

			_body = new Body(bodyType);
			_body.position.setxy(_data.x, _data.y);
			_body.rotation = _data.angle;

			for (var i:int = 0; i < _shapeObjectList.length; i++)
			{
				for (var i2:int = 0; i2 < _shapeObjectList[i].shapes.length; i2++)
				{
					_body.shapes.add(_shapeObjectList[i].shapes[i2]);
				}
			}

			if (_data.material)
			{
				var material:Material = new Material(_data.material.elasticity, data.material.dynamicFriction,
						data.material.staticFriction, data.material.density, data.material.rollingFriction);

				_body.setShapeMaterials(material);
			}

			_body.align();

			_body.allowRotation = _data.allowRotation;
		}

		public function get data():BodyDataVo
		{
			return _data;
		}

		public function get body():Body
		{
			return _body;
		}

		override public function dispose():void
		{
			for each (var shapeObject:IShapeObject in _shapeObjectList)
			{
				shapeObject.dispose();
			}

			_body.shapes.clear();

			_shapeObjectList = null;
			_body = null;
			_data = null;

			super.dispose();
		}
	}
}
