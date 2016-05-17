/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.physics
{
	import com.crazyfm.devkit.physics.vo.units.CFShapeDataVo;
	import com.crazyfm.extensions.physics.ShapeObject;
	import com.crazyfm.extensions.physics.factories.IPhysicsObjectFactory;

	import nape.shape.Shape;

	public class CFShapeObject extends ShapeObject implements ICFShapeObject
	{
		private var _data:CFShapeDataVo;

		public function CFShapeObject(data:CFShapeDataVo, factory:IPhysicsObjectFactory = null)
		{
			_data = data;

			super(data, factory);
		}

		override protected function applyCustomData(shape:Shape):void
		{
			super.applyCustomData(shape);

			if (isLadder)
			{
				shape.sensorEnabled = true;
			}
		}

		override public function dispose():void
		{
			_data = null;

			super.dispose();
		}

		public function get isLadder():Boolean
		{
			return _data.isLadder;
		}

		public function get exitFromShapeId():String
		{
			return _data.exitFromShapeId;
		}

		public function get exitToShapeId():String
		{
			return _data.exitToShapeId;
		}
	}
}
