/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;

	import nape.phys.Body;

	public class BodyObject implements IBodyObject
	{
		private var _body:Body;

		private var _data:BodyDataVo;

		private var _shapeDataList:Vector.<IShapeObject>;

		public function BodyObject()
		{
		}

		public function get shapeDataList():Vector.<IShapeObject>
		{
			return _shapeDataList;
		}

		public function set data(value:BodyDataVo):void
		{
			_data = value;

			_shapeDataList = new <IShapeObject>[];

			for each (var shapeData:ShapeDataVo in _data.shapesData)
			{
				var shapeObject:IShapeObject = new ShapeObject();
				shapeObject.data = shapeData;
				_shapeDataList.push(shapeObject);
			}

			//TODO: body type
			_body = new Body();

			for (var i:int = 0; i < _shapeDataList.length; i++)
			{
				for (var i2:int = 0; i2 < _shapeDataList[i].shapes.length; i2++)
				{
					_body.shapes.add(_shapeDataList[i].shapes[i2]);
				}
			}
		}

		public function get data():BodyDataVo
		{
			return _data;
		}

		public function get body():Body
		{
			return _body;
		}
	}
}
