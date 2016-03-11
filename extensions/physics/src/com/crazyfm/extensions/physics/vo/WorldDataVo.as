/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class WorldDataVo
	{
		private var _bodiesData:Vector.<BodyDataVo>;

		public function WorldDataVo(bodiesData:Vector.<BodyDataVo>)
		{
			_bodiesData = bodiesData;
		}

		public function get bodiesData():Vector.<BodyDataVo>
		{
			return _bodiesData;
		}
	}
}
