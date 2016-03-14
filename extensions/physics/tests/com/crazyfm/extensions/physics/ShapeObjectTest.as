/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import flexunit.framework.Assert;

	public class ShapeObjectTest
	{
		private var s:IShapeObject;

		[Before]
		public function setUp():void
		{
			s = new ShapeObject();
			var sd:ShapeDataVo = new ShapeDataVo();
			sd.vertexDataList = new <VertexDataVo>[new VertexDataVo(0, 0), new VertexDataVo(10, 10), new VertexDataVo(50, 75)];
			s.data = sd;

		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testData():void
		{
			Assert.assertNotNull(s.data);
		}

		[Test]
		public function testVertices():void
		{
			Assert.assertNotNull(s.vertexObjectList);
			Assert.assertEquals(s.vertexObjectList[0].x, 0);
			Assert.assertEquals(s.vertexObjectList[0].y, 0);
			Assert.assertEquals(s.vertexObjectList[1].x, 10);
			Assert.assertEquals(s.vertexObjectList[1].y, 10);
			Assert.assertEquals(s.vertexObjectList[2].x, 50);
			Assert.assertEquals(s.vertexObjectList[2].y, 75);
		}

		[Test]
		public function testGetShapes():void
		{
			Assert.assertEquals(s.shapes.length, 1);
		}
	}
}
