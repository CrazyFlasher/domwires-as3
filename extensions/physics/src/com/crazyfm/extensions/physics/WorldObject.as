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

		private var _bodyObjectList:Vector.<IBodyObject>;

		public function WorldObject()
		{
		}

		public function set data(value:WorldDataVo):void
		{
			_data = value;

			_bodyObjectList = new <IBodyObject>[];

			for each (var bodyData:BodyDataVo in _data.bodyDataList)
			{
				var bodyObject:IBodyObject = new BodyObject();
				bodyObject.data = bodyData;
				_bodyObjectList.push(bodyObject);
			}
		}

		public function get data():WorldDataVo
		{
			return _data;
		}

		public function get bodyObjectList():Vector.<IBodyObject>
		{
			return _bodyObjectList;
		}
	}
}
