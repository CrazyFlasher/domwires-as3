/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.JointDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	public class PhysicsFactory implements IPhysicsFactory
	{
		public function PhysicsFactory()
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
			return new VertexObject(data);
		}
	}
}
