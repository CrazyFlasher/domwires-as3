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

		private var _shapeObjectList:Vector.<IShapeObject>;

		public function BodyObject()
		{
		}

		public function get shapeObjectList():Vector.<IShapeObject>
		{
			return _shapeObjectList;
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

			//TODO: body type
			_body = new Body();

			for (var i:int = 0; i < _shapeObjectList.length; i++)
			{
				for (var i2:int = 0; i2 < _shapeObjectList[i].shapes.length; i2++)
				{
					_body.shapes.add(_shapeObjectList[i].shapes[i2]);
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
