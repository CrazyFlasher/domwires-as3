/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.utils
{
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
				bodies: [
					{
						name: "body_1",
						type: "dynamic",
						x: 0,
						y: 0,
						angle: 0,
						shapes: [
							{
								name: "shape_1",
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
							}
						]
					}
				]
			};

			var w:WorldDataVo = PhysicsParser.parseWorld(obj);

			Assert.assertEquals(w.bodyDataList.length, 1);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList.length, 1);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList.length, 1);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList[0].x, 5);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList[0].y, 7);
		}
	}
}
