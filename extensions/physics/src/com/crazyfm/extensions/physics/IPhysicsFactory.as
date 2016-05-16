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

	public interface IPhysicsFactory
	{
		function getWorld(data:WorldDataVo):IWorldObject;
		function getJoint(data:JointDataVo):IJointObject;
		function getBody(data:BodyDataVo):IBodyObject;
		function getShape(data:ShapeDataVo):IShapeObject;
		function getVertex(data:VertexDataVo):IVertexObject;
	}
}
