/**
 * Created by Anton Nefjodov on 17.05.2016.
 */
package com.crazyfm.extensions.physics.factories
{
	import com.crazyfm.extensions.physics.vo.units.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.units.JointDataVo;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.units.VertexDataVo;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	public interface IPhysicsVoFactory
	{
		function parseWorld(worldJson:Object, toData:WorldDataVo = null):WorldDataVo;
		function parseJoint(jointJson:Object, toData:JointDataVo = null):JointDataVo;
		function parseBody(bodyJson:Object, toData:BodyDataVo = null):BodyDataVo;
		function parseShape(shapeJson:Object, toData:ShapeDataVo = null):ShapeDataVo;
		function parseVertex(vertexJson:Object, toData:VertexDataVo = null):VertexDataVo;
	}
}
