/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.physics.factories
{
	import com.crazyfm.devkit.physics.*;
	import com.crazyfm.devkit.physics.vo.units.CFShapeDataVo;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.factories.PhysicsObjectFactory;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;

	public class CFPhysicsObjectFactory extends PhysicsObjectFactory
	{
		public function CFPhysicsObjectFactory()
		{
			super();
		}

		override public function getShape(data:ShapeDataVo):IShapeObject
		{
			if (!(data is CFShapeDataVo))
			{
				throw new Error("Invalid type: CFShapeDataVo required!");
			}

			return new CFShapeObject(data as CFShapeDataVo, this);
		}
	}
}
