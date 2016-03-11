/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	import nape.phys.Body;

	public class WorldObject implements IWorldObject
	{
		private var _data:WorldDataVo;

		private var _bodiesDataList:Vector.<IBodyObject>;

		public function WorldObject()
		{
		}

		public function get bodiesDataList():Vector.<IBodyObject>
		{
			return _bodiesDataList;
		}

		public function set data(value:WorldDataVo):void
		{
			_data = value;

			_bodiesDataList = new <IBodyObject>[];

			for each (var bodyData:BodyDataVo in _data.bodiesData)
			{
				var bodyObject:IBodyObject = new BodyObject();
				bodyObject.data = bodyData;
				_bodiesDataList.push(bodyObject);
			}
		}

		public function get data():WorldDataVo
		{
			return _data;
		}

		public function get bodies():Vector.<Body>
		{
			return null;
		}
	}
}
