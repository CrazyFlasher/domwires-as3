/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.physics
{
	import com.crazyfm.extensions.physics.IPhysicsFactory;
	import com.crazyfm.extensions.physics.ShapeObject;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;

	import nape.shape.Shape;

	public class CFShapeObject extends ShapeObject implements ICFShapeObject
	{
		public function CFShapeObject(data:ShapeDataVo, factory:IPhysicsFactory = null)
		{
			super(data, factory);
		}

		public function get isLadder():Boolean
		{
			return data.customData.isLadder;
		}

		override protected function applyCustomData(shape:Shape):void
		{
			super.applyCustomData(shape);

			if (data.customData.isLadder || data.customData.isLadderExitFrom || data.customData.isLadderExitTo)
			{
				shape.sensorEnabled = true;
				data.customData.isLadder = true;
			}
		}
	}
}
