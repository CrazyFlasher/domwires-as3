/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.utils
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.GravityVo;
	import com.crazyfm.extensions.physics.vo.InteractionFilterVo;
	import com.crazyfm.extensions.physics.vo.JointDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeMaterialVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	public class PhysicsParser
	{
		public static function parseVertex(vertexJson:Object):VertexDataVo
		{
			var x:Number = vertexJson.x != null ? vertexJson.x : 0;
			var y:Number = vertexJson.y != null ? vertexJson.y : 0;

			return new VertexDataVo(x, y, vertexJson.id);
		}

		public static function parseShape(shapeJson:Object):ShapeDataVo
		{
			var vertices:Vector.<VertexDataVo> = new <VertexDataVo>[];
			for each (var vertexJson:Object in shapeJson.vertices)
			{
				var vertexData:VertexDataVo = parseVertex(vertexJson);
				vertices.push(vertexData);
			}

			var data:ShapeDataVo = new ShapeDataVo();
			data.vertexDataList = vertices;
			data.id = shapeJson.id;
			if(shapeJson.radius != null)
			{
				data.radius = shapeJson.radius;
			}else
			if(shapeJson.x != null)
			{
				data.x = shapeJson.x;
			}
			if(shapeJson.y != null)
			{
				data.y = shapeJson.y;
			}
			if(shapeJson.angle != null)
			{
				data.angle = shapeJson.angle;
			}


			if(shapeJson.material)
			{
				var material:ShapeMaterialVo = new ShapeMaterialVo();
				if(shapeJson.material.elasticity)
				{
					material.elasticity = shapeJson.material.elasticity;
				}
				if(shapeJson.material.dynamicFriction)
				{
					material.dynamicFriction = shapeJson.material.dynamicFriction;
				}
				if(shapeJson.material.staticFriction)
				{
					material.staticFriction = shapeJson.material.staticFriction;
				}
				if(shapeJson.material.density)
				{
					material.density = shapeJson.material.density;
				}
				if(shapeJson.material.rollingFriction)
				{
					material.rollingFriction = shapeJson.material.rollingFriction;
				}

				data.material = material;
			}

			if(shapeJson.filter)
			{
				var filter:InteractionFilterVo = new InteractionFilterVo();
				if(shapeJson.filter.collisionGroup)
				{
					filter.collisionGroup = shapeJson.filter.collisionGroup;
				}
				if(shapeJson.filter.collisionMask)
				{
					filter.collisionMask = shapeJson.filter.collisionMask;
				}
				if(shapeJson.filter.sensorGroup)
				{
					filter.sensorGroup = shapeJson.filter.sensorGroup;
				}
				if(shapeJson.filter.sensorMask)
				{
					filter.sensorMask = shapeJson.filter.sensorMask;
				}
				if(shapeJson.filter.fluidGroup)
				{
					filter.fluidGroup = shapeJson.filter.fluidGroup;
				}
				if(shapeJson.filter.fluidMask)
				{
					filter.fluidMask = shapeJson.filter.fluidMask;
				}

				data.interactionFilter = filter;
			}

			return data;
		}

		public static function parseBody(bodyJson:Object):BodyDataVo
		{
			var shapes:Vector.<ShapeDataVo> = new <ShapeDataVo>[];
			for each (var shapeJson:Object in bodyJson.shapes)
			{
				var shapeData:ShapeDataVo = parseShape(shapeJson);
				shapes.push(shapeData);
			}

			var data:BodyDataVo = new BodyDataVo();
			data.shapeDataList = shapes;
			data.id = bodyJson.id;
			if(bodyJson.x != null)
			{
				data.x = bodyJson.x;
			}
			if(bodyJson.y != null)
			{
				data.y = bodyJson.y;
			}
			if(bodyJson.angle != null)
			{
				data.angle = bodyJson.angle;
			}
			data.type = bodyJson.type;

			return data;
		}

		private static function parseJoint(jointJson:Object):JointDataVo
		{
			var data:JointDataVo = new JointDataVo();
			data.id = jointJson.id;
			if(jointJson.x != null)
			{
				data.x = jointJson.x;
			}
			if(jointJson.y != null)
			{
				data.y = jointJson.y;
			}
			if(jointJson.minAngle != null)
			{
				data.minAngle = jointJson.minAngle;
			}
			if(jointJson.maxAngle != null)
			{
				data.maxAngle = jointJson.maxAngle;
			}
			if(jointJson.bodies != null && jointJson.bodies.length > 0)
			{
				data.bodyToConnectIdList = new <String>[];

				for each (var bodyId:String in jointJson.bodies)
				{
					data.bodyToConnectIdList.push(bodyId);
				}
			}
			data.type = jointJson.type;

			return data;
		}

		public static function parseWorld(worldJson:Object):WorldDataVo
		{
			var bodies:Vector.<BodyDataVo> = new <BodyDataVo>[];
			for each (var bodyJson:Object in worldJson.bodies)
			{
				var bodyData:BodyDataVo = parseBody(bodyJson);
				bodies.push(bodyData);
			}

			var joints:Vector.<JointDataVo> = new <JointDataVo>[];
			for each (var jointJson:Object in worldJson.joints)
			{
				var jointData:JointDataVo = parseJoint(jointJson);
				joints.push(jointData);
			}

			var data:WorldDataVo = new WorldDataVo();
			data.bodyDataList = bodies;
			data.jointDataList = joints;
			data.id = worldJson.id;
			data.gravity = new GravityVo(worldJson.gravity.x, worldJson.gravity.y);

			return data;
		}
	}
}
