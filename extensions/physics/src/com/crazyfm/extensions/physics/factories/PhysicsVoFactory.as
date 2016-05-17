/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.factories
{
	import com.crazyfm.extensions.physics.vo.GravityVo;
	import com.crazyfm.extensions.physics.vo.InteractionFilterVo;
	import com.crazyfm.extensions.physics.vo.ShapeMaterialVo;
	import com.crazyfm.extensions.physics.vo.units.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.units.JointDataVo;
	import com.crazyfm.extensions.physics.vo.units.PhysicsUnitDataVo;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.units.VertexDataVo;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	public class PhysicsVoFactory implements IPhysicsVoFactory
	{
		public function PhysicsVoFactory()
		{
		}

		public function parseVertex(vertexJson:Object, toData:VertexDataVo = null):VertexDataVo
		{
			var data:VertexDataVo = !toData ? new VertexDataVo() : toData;

			var x:Number = vertexJson.x != null ? vertexJson.x : 0;
			var y:Number = vertexJson.y != null ? vertexJson.y : 0;

			data.id = vertexJson.id;
			data.x = x;
			data.y = y;

			addCustomData(vertexJson.customData, data);

			return data;
		}

		public function parseShape(shapeJson:Object, toData:ShapeDataVo = null):ShapeDataVo
		{
			var vertices:Vector.<VertexDataVo> = new <VertexDataVo>[];
			for each (var vertexJson:Object in shapeJson.vertices)
			{
				var vertexData:VertexDataVo = parseVertex(vertexJson);
				vertices.push(vertexData);
			}

			var data:ShapeDataVo = !toData ? new ShapeDataVo() : toData;
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

			data.material = parseMaterial(shapeJson.material);
			data.interactionFilter = parseFilter(shapeJson.filter);

			addCustomData(shapeJson.customData, data);

			return data;
		}

		public function parseBody(bodyJson:Object, toData:BodyDataVo = null):BodyDataVo
		{
			var shapes:Vector.<ShapeDataVo> = new <ShapeDataVo>[];
			for each (var shapeJson:Object in bodyJson.shapes)
			{
				var shapeData:ShapeDataVo = parseShape(shapeJson);
				shapes.push(shapeData);
			}

			var data:BodyDataVo = !toData ? new BodyDataVo() : toData;
			data.shapeDataList = shapes;
			data.id = bodyJson.id;

			data.material = parseMaterial(bodyJson.material);
			data.interactionFilter = parseFilter(bodyJson.filter);

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

			addCustomData(bodyJson.customData, data);

			return data;
		}

		public function parseJoint(jointJson:Object, toData:JointDataVo = null):JointDataVo
		{
			var data:JointDataVo = !toData ? new JointDataVo() : toData;
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

			addCustomData(jointJson.customData, data);

			return data;
		}

		public function parseWorld(worldJson:Object, toData:WorldDataVo = null):WorldDataVo
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

			var data:WorldDataVo = !toData ? new WorldDataVo() : toData;
			data.bodyDataList = bodies;
			data.jointDataList = joints;
			data.id = worldJson.id;
			data.gravity = new GravityVo(worldJson.gravity.x, worldJson.gravity.y);

			addCustomData(worldJson.customData, data);

			return data;
		}

		//Utils

		private static function getNumberValue(value:*):Number
		{
			if (value == "NaN")
			{
				return NaN;
			}

			return value as Number;
		}

		private static function parseFilter(filterJson:Object):InteractionFilterVo
		{
			if(filterJson)
			{
				var filter:InteractionFilterVo = new InteractionFilterVo();
				if(filterJson.collisionGroup != null)
				{
					filter.collisionGroup = filterJson.collisionGroup;
				}
				if(filterJson.collisionMask != null)
				{
					filter.collisionMask = filterJson.collisionMask;
				}
				if(filterJson.sensorGroup != null)
				{
					filter.sensorGroup = filterJson.sensorGroup;
				}
				if(filterJson.sensorMask != null)
				{
					filter.sensorMask = filterJson.sensorMask;
				}
				if(filterJson.fluidGroup != null)
				{
					filter.fluidGroup = filterJson.fluidGroup;
				}
				if(filterJson.fluidMask != null)
				{
					filter.fluidMask = filterJson.fluidMask;
				}

				return filter;
			}

			return new InteractionFilterVo();
		}

		private static function parseMaterial(materialJson:Object):ShapeMaterialVo
		{
			if(materialJson)
			{
				var material:ShapeMaterialVo = new ShapeMaterialVo();
				if(materialJson.elasticity != null)
				{
					material.elasticity = getNumberValue(materialJson.elasticity);
				}
				if(materialJson.dynamicFriction != null)
				{
					material.dynamicFriction = getNumberValue(materialJson.dynamicFriction);
				}
				if(materialJson.staticFriction != null)
				{
					material.staticFriction = getNumberValue(materialJson.staticFriction);
				}
				if(materialJson.density != null)
				{
					material.density = getNumberValue(materialJson.density);
				}
				if(materialJson.rollingFriction != null)
				{
					material.rollingFriction = getNumberValue(materialJson.rollingFriction);
				}

				return material;
			}

			return new ShapeMaterialVo();
		}

		private static function addCustomData(customDataJson:Object, toData:PhysicsUnitDataVo):void
		{
			if (customDataJson)
			{
				toData.customData = customDataJson;
			}
		}
	}
}
