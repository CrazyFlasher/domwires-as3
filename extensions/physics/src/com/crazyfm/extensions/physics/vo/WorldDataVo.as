/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class WorldDataVo
	{
		private var _id:String;
		private var _gravity:GravityVo;

		private var _bodyDataList:Vector.<BodyDataVo>;

		public function WorldDataVo()
		{
		}

		public function get bodyDataList():Vector.<BodyDataVo>
		{
			return _bodyDataList;
		}

		public function set bodyDataList(value:Vector.<BodyDataVo>):void
		{
			_bodyDataList = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get gravity():GravityVo
		{
			return _gravity;
		}

		public function set gravity(value:GravityVo):void
		{
			_gravity = value;
		}
	}
}
