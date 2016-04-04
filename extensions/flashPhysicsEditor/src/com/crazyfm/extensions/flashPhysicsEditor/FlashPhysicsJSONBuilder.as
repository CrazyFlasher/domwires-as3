﻿/**
 * Created by Anton Nefjodov on 14.03.2016.
 */
package com.crazyfm.extensions.flashPhysicsEditor {

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;

	public class FlashPhysicsJSONBuilder extends MovieClip
	{
		public function FlashPhysicsJSONBuilder()
		{
			this.gotoAndStop(2);

			var world:MovieClip;

			for each (var obj:MovieClip in getAllChildren(this))
			{
				if (getQualifiedClassName(obj) == "$world")
				{
					world = obj;
					break;
				}
			}

			var worldData:Object =
			{
				id:world.name,
				bodies:[

				],
				joints:[

				]
			};

			if(world.gravity)
			{
				worldData.gravity = world.gravity;
			}else
			{
				worldData.gravity = {x:0, y:100};
			}

			for each (var physObject:MovieClip in getAllChildren(world))
			{
				var body:MovieClip;
				var joint:MovieClip;

				if(physObject is MovieClip)
				{
					if(getQualifiedClassName(physObject) == "$pivot_angle_joint")
					{
						joint = physObject;

						var jointData:Object = {
							id:joint.name,
							type:"pivot_angle",
							x:joint.x,
							y:joint.y,
							minAngle:joint.minAngle,
							maxAngle:joint.maxAngle
						};
						if(joint.bodies)
						{
							jointData.bodies = joint.bodies;
						}
						worldData.joints.push(jointData);
					}else
					{
						body = physObject;

						var bodyData:Object = {
							x:body.x,
							y:body.y,
							angle:body.rotation * Math.PI / 180,
							id:body.name,
							type:body.type,
							shapes:getBodyShapes(body)
						};

						if (body.material != null)
						{
							bodyData.material = {};
							if(body.material.elasticity != null)
							{
								bodyData.material.elasticity = getNumberValue(body.material.elasticity);
							}
							if(body.material.dynamicFriction != null)
							{
								bodyData.material.dynamicFriction = getNumberValue(body.material.dynamicFriction);
							}
							if(body.material.staticFriction != null)
							{
								bodyData.material.staticFriction = getNumberValue(body.material.staticFriction);
							}
							if(body.material.density != null)
							{
								bodyData.material.density = getNumberValue(body.material.density);
							}
							if(body.material.rollingFriction != null)
							{
								bodyData.material.rollingFriction = getNumberValue(body.material.rollingFriction);
							}
						}

						if (body.allowRotation != null)
						{
							bodyData.allowRotation = body.allowRotation != false;
						}

						worldData.bodies.push(bodyData);
					}
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
						x:shape.x,
						y:shape.y,
						angle:shape.rotation * Math.PI / 180,
						id:shape.name
					};
					if(getQualifiedClassName(shape) == "$circle_shape")
					{
						shapeData.radius = shape.width / 2;
					}else
					{
						shapeData.vertices = getShapeVertices(shape);
					}
					if(shape.filter)
					{
						shapeData.filter = {};
						if(shape.filter.collisionGroup != null)
						{
							shapeData.filter.collisionGroup = shape.filter.collisionGroup;
						}
						if(shape.filter.collisionMask != null)
						{
							shapeData.filter.collisionMask = shape.filter.collisionMask;
						}
						if(shape.filter.sensorGroup != null)
						{
							shapeData.filter.sensorGroup = shape.filter.sensorGroup;
						}
						if(shape.filter.sensorMask != null)
						{
							shapeData.filter.sensorMask = shape.filter.sensorMask;
						}
						if(shape.filter.fluidGroup != null)
						{
							shapeData.filter.fluidGroup = shape.filter.fluidGroup;
						}
					}
					if(shape.material)
					{
						shapeData.material = {};
						if(shape.material.elasticity != null)
						{
							shapeData.material.elasticity = getNumberValue(shape.material.elasticity);
						}
						if(shape.material.dynamicFriction != null)
						{
							shapeData.material.dynamicFriction = getNumberValue(shape.material.dynamicFriction);
						}
						if(shape.material.staticFriction != null)
						{
							shapeData.material.staticFriction = getNumberValue(shape.material.staticFriction);
						}
						if(shape.material.density != null)
						{
							shapeData.material.density = getNumberValue(shape.material.density);
						}
						if(shape.material.rollingFriction != null)
						{
							shapeData.material.rollingFriction = getNumberValue(shape.material.rollingFriction);
						}
					}
					shapes.push(shapeData);
				}
			}

			return shapes;
		}

		private function getNumberValue(value:Number):*
		{
			if (isNaN(value))
			{
				return "NaN";
			}

			return value;
		}

		private function getShapeVertices(shape:Object):Array
		{
			var vertices:Vector.<Object> = new <Object>[];

			for each (var vertex:Object in getAllChildren(shape as DisplayObjectContainer))
			{
				if (getQualifiedClassName(vertex) == "$vertex")
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
