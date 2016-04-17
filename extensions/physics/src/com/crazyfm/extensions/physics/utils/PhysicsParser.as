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
			if(shapeJson.isSensor != null)
			{
				data.sensor = shapeJson.isSensor;
			}
			if(shapeJson.radius != null)
			{
				data.radius = shapeJson.radius;
			}
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
				if(shapeJson.material.elasticity != null)
				{
					material.elasticity = getNumberValue(shapeJson.material.elasticity);
				}
				if(shapeJson.material.dynamicFriction != null)
				{
					material.dynamicFriction = getNumberValue(shapeJson.material.dynamicFriction);
				}
				if(shapeJson.material.staticFriction != null)
				{
					material.staticFriction = getNumberValue(shapeJson.material.staticFriction);
				}
				if(shapeJson.material.density != null)
				{
					material.density = getNumberValue(shapeJson.material.density);
				}
				if(shapeJson.material.rollingFriction != null)
				{
					material.rollingFriction = getNumberValue(shapeJson.material.rollingFriction);
				}

				data.material = material;
			}

			if(shapeJson.filter)
			{
				var filter:InteractionFilterVo = new InteractionFilterVo();
				if(shapeJson.filter.collisionGroup != null)
				{
					filter.collisionGroup = shapeJson.filter.collisionGroup;
				}
				if(shapeJson.filter.collisionMask != null)
				{
					filter.collisionMask = shapeJson.filter.collisionMask;
				}
				if(shapeJson.filter.sensorGroup != null)
				{
					filter.sensorGroup = shapeJson.filter.sensorGroup;
				}
				if(shapeJson.filter.sensorMask != null)
				{
					filter.sensorMask = shapeJson.filter.sensorMask;
				}
				if(shapeJson.filter.fluidGroup != null)
				{
					filter.fluidGroup = shapeJson.filter.fluidGroup;
				}
				if(shapeJson.filter.fluidMask != null)
				{
					filter.fluidMask = shapeJson.filter.fluidMask;
				}

				data.interactionFilter = filter;
			}

			return data;
		}

		private static function getNumberValue(value:*):Number
		{
			if (value == "NaN")
			{
				return NaN;
			}

			return value as Number;
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
			if(bodyJson.material)
			{
				var material:ShapeMaterialVo = new ShapeMaterialVo();
				if(bodyJson.material.elasticity != null)
				{
					material.elasticity = getNumberValue(bodyJson.material.elasticity);
				}
				if(bodyJson.material.dynamicFriction != null)
				{
					material.dynamicFriction = getNumberValue(bodyJson.material.dynamicFriction);
				}
				if(bodyJson.material.staticFriction != null)
				{
					material.staticFriction = getNumberValue(bodyJson.material.staticFriction);
				}
				if(bodyJson.material.density != null)
				{
					material.density = getNumberValue(bodyJson.material.density);
				}
				if(bodyJson.material.rollingFriction != null)
				{
					material.rollingFriction = getNumberValue(bodyJson.material.rollingFriction);
				}

				data.material = material;
			}
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
			if(bodyJson.allowRotation != null)
			{
				data.allowRotation = bodyJson.allowRotation;
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
