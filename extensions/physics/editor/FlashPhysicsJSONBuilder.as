/**
 * Created by Anton Nefjodov on 14.03.2016.
 */
package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class FlashPhysicsJSONBuilder extends Sprite
	{
		public function FlashPhysicsJSONBuilder()
		{
			var world:DisplayObjectContainer = new world_1();
			var worldData:Object =
			{
				id:world.name,
				gravity:{
					x:0,
					y:9.8
				},
				bodies:[

				]
			};
			for each (var body:Object in getAllChildren(world))
			{
				if(body is Sprite)
				{
					worldData.bodies.push(
							{
								x:body.x,
								y:body.y,
								angle:body.rotation * Math.PI / 180,
								id:body.name,
								type:body.type,
								shapes:getBodyShapes(body)
							}
					);
				}
			}

			var jsonString:String = JSON.stringify(worldData);
			trace(jsonString);
		}

		private function getBodyShapes(body:Object):Array
		{
			var shapes:Array = [];

			for each (var shape:Object in getAllChildren(body as DisplayObjectContainer))
			{
				if(shape is DisplayObjectContainer)
				{
					var shapeData:Object = {
						x:body.x,
						y:body.y,
						angle:shape.rotation * Math.PI / 180,
						id:shape.name,
						vertices:getShapeVertices(shape)
					};
					if(shape.material)
					{
						shapeData.material = {};
						if(shape.material.elasticity)
						{
							shapeData.material.elasticity = shape.material.elasticity;
						}
						if(shape.material.dynamicFriction)
						{
							shapeData.material.dynamicFriction = shape.material.dynamicFriction;
						}
						if(shape.material.staticFriction)
						{
							shapeData.material.staticFriction = shape.material.staticFriction;
						}
						if(shape.material.density)
						{
							shapeData.material.density = shape.material.density;
						}
						if(shape.material.rollingFriction)
						{
							shapeData.material.rollingFriction = shape.material.rollingFriction;
						}
					}
					shapes.push(shapeData);
				}
			}

			return shapes;
		}

		private function getShapeVertices(shape:Object):Array
		{
			var vertices:Vector.<Object> = new <Object>[];

			for each (var vertex:Object in getAllChildren(shape as DisplayObjectContainer))
			{
				if (vertex is DisplayObjectContainer)
				{
					var vertexData:Object = {
						id:vertex.name,
						x:vertex.x,
						y:vertex.y
					};

					vertices.push(vertexData);
				}
			}

			vertices.sort(sortVertices);

			return toArray(vertices);
		}

		private function sortVertices(v1:Object, v2:Object):Number
		{
			var index_1:int = parseInt(v1.id.split("_")[1]);
			var index_2:int = parseInt(v2.id.split("_")[1]);

			if(index_1 > index_2){
				return 1;
			}
			if(index_1 < index_2){
				return -1;
			}
			return 0;
		}

		private function toArray(iterable:*):Array {
			var ret:Array = [];
			for each (var elem:* in iterable) ret.push(elem);
			return ret;
		}

		private function getAllChildren(container:DisplayObjectContainer):Array {
			var allChildren:Array = [];
			var l:uint = container.numChildren;
			while (l--) {
				allChildren.push(container.getChildAt(l));
			}
			return allChildren;
		}
	}
}
