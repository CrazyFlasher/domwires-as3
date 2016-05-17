/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.extensions.physics.factories
{
	import com.crazyfm.extensions.physics.*;
	import com.crazyfm.extensions.physics.vo.units.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.units.JointDataVo;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.units.VertexDataVo;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	public class PhysicsObjectFactory implements IPhysicsObjectFactory
	{
		public function PhysicsObjectFactory()
		{
		}

		public function getWorld(data:WorldDataVo):IWorldObject
		{
			return new WorldObject(data, this);
		}

		public function getJoint(data:JointDataVo):IJointObject
		{
			return new JointObject(data, this);
		}

		public function getBody(data:BodyDataVo):IBodyObject
		{
			return new BodyObject(data, this);
		}

		public function getShape(data:ShapeDataVo):IShapeObject
		{
			return new ShapeObject(data, this);
		}

		public function getVertex(data:VertexDataVo):IVertexObject
		{
			return new VertexObject(data, this);
		}
	}
}
