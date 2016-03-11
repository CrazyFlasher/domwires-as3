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
			b.data = new BodyDataVo(new <ShapeDataVo>[
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(10, 10), new VertexDataVo(25, 30)]),
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(5, 7), new VertexDataVo(11, 17)]),
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(8, 12), new VertexDataVo(3, 28)])
			]);
		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testShapes():void
		{
			Assert.assertEquals(b.shapes.length, 3);
			Assert.assertEquals(b.shapes[0].vertices.length, 2);
			Assert.assertEquals(b.shapes[1].vertices.length, 2);
			Assert.assertEquals(b.shapes[0].vertices[0].x, 10);
			Assert.assertEquals(b.shapes[2].vertices[1].y, 28);
		}

		[Test]
		public function testData():void
		{
			Assert.assertNotNull(b.data);
		}
	}
}
