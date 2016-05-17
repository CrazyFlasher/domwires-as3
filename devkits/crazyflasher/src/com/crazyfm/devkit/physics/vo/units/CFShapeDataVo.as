/**
 * Created by Anton Nefjodov on 17.05.2016.
 */
package com.crazyfm.devkit.physics.vo.units
{
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;

	public class CFShapeDataVo extends ShapeDataVo
	{
		private var _isLadder:Boolean;
		private var _exitFromShapeId:String;
		private var _exitToShapeId:String;

		public function CFShapeDataVo()
		{
			super();
		}

		public function get isLadder():Boolean
		{
			return _isLadder;
		}

		public function set isLadder(value:Boolean):void
		{
			_isLadder = value;
		}

		public function get exitFromShapeId():String
		{
			return _exitFromShapeId;
		}

		public function set exitFromShapeId(value:String):void
		{
			_exitFromShapeId = value;
		}

		public function get exitToShapeId():String
		{
			return _exitToShapeId;
		}

		public function set exitToShapeId(value:String):void
		{
			_exitToShapeId = value;
		}
	}
}
