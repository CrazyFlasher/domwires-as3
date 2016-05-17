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

	public interface IPhysicsObjectFactory
	{
		function getWorld(data:WorldDataVo):IWorldObject;
		function getJoint(data:JointDataVo):IJointObject;
		function getBody(data:BodyDataVo):IBodyObject;
		function getShape(data:ShapeDataVo):IShapeObject;
		function getVertex(data:VertexDataVo):IVertexObject;
	}
}
