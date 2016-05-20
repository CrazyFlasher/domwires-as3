/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.crazyfm.extensions.physics.vo.units
{
	public class JointDataVo extends PhysicsUnitDataVo
	{
		private var _minAngle:Number;
		private var _maxAngle:Number;
		private var _type:String;
		private var _bodyToConnectIdList:Vector.<String>;

		public function JointDataVo(json:Object)
		{
			super(json);

			if(json.minAngle != null)
			{
				_minAngle = json.minAngle;
			}
			if(json.maxAngle != null)
			{
				_maxAngle = json.maxAngle;
			}
			if(json.bodies != null && json.bodies.length > 0)
			{
				_bodyToConnectIdList = new <String>[];

				for each (var bodyId:String in json.bodies)
				{
					_bodyToConnectIdList.push(bodyId);
				}
			}
			_type = json.type;
		}

		public function get minAngle():Number
		{
			return _minAngle;
		}

		public function set minAngle(value:Number):void
		{
			_minAngle = value;
		}

		public function get maxAngle():Number
		{
			return _maxAngle;
		}

		public function set maxAngle(value:Number):void
		{
			_maxAngle = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get bodyToConnectIdList():Vector.<String>
		{
			return _bodyToConnectIdList;
		}

		public function set bodyToConnectIdList(value:Vector.<String>):void
		{
			_bodyToConnectIdList = value;
		}
	}
}
