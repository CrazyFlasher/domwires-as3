/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.physics
{
	import com.crazyfm.extensions.physics.IPhysicsFactory;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.PhysicsFactory;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;

	public class CFPhysicsFactory extends PhysicsFactory implements IPhysicsFactory
	{
		public function CFPhysicsFactory()
		{
			super();
		}

		override public function getShape(data:ShapeDataVo):IShapeObject
		{
			return new CFShapeObject(data, this);
		}
	}
}
