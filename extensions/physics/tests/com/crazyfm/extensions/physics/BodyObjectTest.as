/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import flexunit.framework.Assert;

	public class BodyObjectTest
	{
		private var b:IBodyObject;

		[Before]
		public function setUp():void
		{
			b = new BodyObject();

			var s_1:ShapeDataVo = new ShapeDataVo();
			var s_2:ShapeDataVo = new ShapeDataVo();
			var s_3:ShapeDataVo = new ShapeDataVo();

			s_1.vertexDataList = new <VertexDataVo>[new VertexDataVo(10, 10), new VertexDataVo(25, 30), new VertexDataVo(10, 50)];
			s_2.vertexDataList = new <VertexDataVo>[new VertexDataVo(60, 60), new VertexDataVo(75, 80), new VertexDataVo(60, 100)];
			s_3.vertexDataList = new <VertexDataVo>[new VertexDataVo(110, 110), new VertexDataVo(125, 130), new VertexDataVo(110, 150)];

			var bd:BodyDataVo = new BodyDataVo();
			bd.shapeDataList = new <ShapeDataVo>[s_1, s_2, s_3];

			b.data = bd;
		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testShapes():void
		{
			Assert.assertEquals(b.shapeObjectList.length, 3);
			Assert.assertEquals(b.shapeObjectList[0].vertexObjectList.length, 3);
			Assert.assertEquals(b.shapeObjectList[1].vertexObjectList.length, 3);
			Assert.assertEquals(b.shapeObjectList[0].vertexObjectList[0].x, 10);
			Assert.assertEquals(b.shapeObjectList[2].vertexObjectList[1].y, 130);
		}

		[Test]
		public function testData():void
		{
			Assert.assertNotNull(b.data);
		}

		[Test]
		public function testGetBody():void
		{
			Assert.assertEquals(b.body.shapes.length, 3);
		}
	}
}
