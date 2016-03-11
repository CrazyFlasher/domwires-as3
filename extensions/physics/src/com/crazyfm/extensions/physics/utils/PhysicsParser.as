/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.utils
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	public class PhysicsParser
	{
		public static function parseVertex(vertexJson:Object):VertexDataVo
		{
			return new VertexDataVo(vertexJson.x, vertexJson.y);
		}

		public static function parseShape(shapeJson:Object):ShapeDataVo
		{
			var vertices:Vector.<VertexDataVo> = new <VertexDataVo>[];
			for each (var vertexJson:Object in shapeJson.vertices)
			{
				var vertexData:VertexDataVo = parseVertex(vertexJson);
				vertices.push(vertexData);
			}

			return new ShapeDataVo(vertices);
		}

		public static function parseBody(bodyJson:Object):BodyDataVo
		{
			var shapes:Vector.<ShapeDataVo> = new <ShapeDataVo>[];
			for each (var shapeJson:Object in bodyJson.shapes)
			{
				var shapeData:ShapeDataVo = parseShape(shapeJson);
				shapes.push(shapeData);
			}

			return new BodyDataVo(shapes);
		}

		public static function parseWorld(worldJson:Object):WorldDataVo
		{
			var bodies:Vector.<BodyDataVo> = new <BodyDataVo>[];
			for each (var bodyJson:Object in worldJson.bodies)
			{
				var bodyData:BodyDataVo = parseBody(bodyJson);
				bodies.push(bodyData);
			}

			return new WorldDataVo(bodies);
		}
	}
}
