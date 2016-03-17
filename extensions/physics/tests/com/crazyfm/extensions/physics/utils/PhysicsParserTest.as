/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.utils
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	import flexunit.framework.Assert;

	public class PhysicsParserTest
	{

		[Before]
		public function setUp():void
		{

		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testParse():void
		{
			var obj:Object =
			{
				id: "world_1",
				gravity: {x: 0, y: 100},
				joints :[
					{
						id:"joint_1",
						type:"pivot",
						x:10,
						y:10,
						minAngle:0,
						maxAngle:Math.PI / 2,
						bodies:["body_1", "$world"]
					}
				],
				bodies: [
					{
						id: "body_1",
						type: "dynamic",
						x: 0,
						y: 0,
						angle: 0,
						shapes: [
							{
								id: "shape_1",
								filter: {
									collisionGroup: 1,
									collisionMask: -1,
									sensorGroup: 1,
									sensorMask: -1,
									fluidGroup: 1,
									fluidMask: -1
								},
								sensor:false,
								material: {elasticity: 0.0, dynamicFriction: 1.0, staticFriction: 2.0, density: 1, rollingFriction: NaN},
								x: 0,
								y: 0,
								angle: 0,
								vertices: [
									{
										x: 5,
										y: 7
									}
								]
							},
							{
								id: "shape_2",
								filter: {
									collisionGroup: -1,
									collisionMask: 1,
									sensorGroup: 1,
									sensorMask: -1,
									fluidGroup: 1,
									fluidMask: -1
								},
								sensor:false,
								material: {elasticity: 0.0, dynamicFriction: 1.0, staticFriction: 2.0, density: 1, rollingFriction: NaN},
								x: 0,
								y: 0,
								angle: 0,
								vertices: [
									{
										x: 5,
										y: 7
									}
								]
							},
							{
								id: "shape_3",
								sensor:true,
								x: 0,
								y: 0,
								angle: 0,
								radius:50
							}
						]
					}
				]
			};

			var w:WorldDataVo = PhysicsParser.parseWorld(obj);

			Assert.assertEquals(w.gravity.x, 0);
			Assert.assertEquals(w.gravity.y, 9.8);
			Assert.assertEquals(w.bodyDataList.length, 1);
			Assert.assertEquals(w.bodyDataList[0].type, BodyDataVo.TYPE_DYNAMIC);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList.length, 3);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList.length, 1);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList[0].x, 5);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList[0].y, 7);
		}
	}
}
