/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class WorldDataVo
	{
		private var _id:String;
		private var _gravityX:Number;
		private var _gravityY:Number;

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

		public function get gravityX():Number
		{
			return _gravityX;
		}

		public function set gravityX(value:Number):void
		{
			_gravityX = value;
		}

		public function get gravityY():Number
		{
			return _gravityY;
		}

		public function set gravityY(value:Number):void
		{
			_gravityY = value;
		}
	}
}
