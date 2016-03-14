/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.utils
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
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

			var material:ShapeMaterialVo = new ShapeMaterialVo();
			if(shapeJson.material)
			{
				material.elasticity = shapeJson.material.elasticity;
				material.dynamicFriction = shapeJson.material.dynamicFriction;
				material.staticFriction = shapeJson.material.staticFriction;
				material.density = shapeJson.material.density;
				material.rollingFriction = shapeJson.material.rollingFriction;
			}

			var data:ShapeDataVo = new ShapeDataVo();
			data.vertexDataList = vertices;
			data.material = material;
			data.id = shapeJson.id;
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

		public static function parseWorld(worldJson:Object):WorldDataVo
		{
			var bodies:Vector.<BodyDataVo> = new <BodyDataVo>[];
			for each (var bodyJson:Object in worldJson.bodies)
			{
				var bodyData:BodyDataVo = parseBody(bodyJson);
				bodies.push(bodyData);
			}

			var data:WorldDataVo = new WorldDataVo();
			data.bodyDataList = bodies;
			data.id = worldJson.id;
			data.gravityX = worldJson.gravityX;
			data.gravityY = worldJson.gravityY;

			return data;
		}
	}
}
