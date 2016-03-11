/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class WorldDataVo
	{
		private var _bodyDataList:Vector.<BodyDataVo>;

		public function WorldDataVo(bodyDataList:Vector.<BodyDataVo>)
		{
			_bodyDataList = bodyDataList;
		}

		public function get bodyDataList():Vector.<BodyDataVo>
		{
			return _bodyDataList;
		}
	}
}
